//
//  FavoritesViewModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 17.12.2025.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    
    private init() {
        loadFavorites()
        Task { await getFavoritesWeather() }
    }
    
    static let shared = FavoritesViewModel()
    private let saveKey = "favorites"
    var networkDataManager = NetworkDataManager.shared
    
    @Published var savedLocations: [SavedFavorite] = []
    @Published var favoritesWeatherData: [CurrentWeatherModel] = []
    
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([SavedFavorite].self, from: data) {
            savedLocations = decoded
        }
    }
    
    
    func getFavoritesWeather() async {
        let weatherData = await withTaskGroup(of: CurrentWeatherModel?.self) { group in
            for city in savedLocations {
                group.addTask {
                    do {
                        return try await self.networkDataManager.fetchWeather(id: city.id, endpoint: "weather")
                    } catch {
                        debugPrint("Error: \(error.localizedDescription), City ID: \(city.id)")
                        return nil
                    }
                }
            }
            var results: [CurrentWeatherModel] = []
            for await result in group {
                if let validData = result {
                    results.append(validData)
                }
            }
            return results
        }
        
        self.favoritesWeatherData = weatherData.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
    }
    
    
    func toggleFavorite(location: SavedFavorite) {
        if isFavorite(id: location.id) {
            savedLocations.removeAll { $0.id == location.id }
            favoritesWeatherData.removeAll { $0.id == location.id }
        } else {
            savedLocations.append(location)
            Task {
                if let newFavoriteData = await fetchSingleWeather(id: location.id) {
                    self.favoritesWeatherData.append(newFavoriteData)
                    self.favoritesWeatherData.sort(by: { ($0.name ?? "") < ($1.name ?? "") })
                }
            }
        }
        if let encoded = try? JSONEncoder().encode(savedLocations) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    
    private func fetchSingleWeather(id: Int) async -> CurrentWeatherModel? {
        do {
            return try await networkDataManager.fetchWeather(id: id, endpoint: "weather")
        } catch {
            debugPrint("Error: Unable to fetch single data ID ID: \(id)")
            return nil
        }
    }
    
    
    func isFavorite(id: Int) -> Bool {
        return savedLocations.contains { $0.id == id }
    }
    
}


struct SavedFavorite: Identifiable, Codable, Equatable {
    let id: Int
}
