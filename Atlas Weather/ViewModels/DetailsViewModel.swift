//
//  DetailsViewModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class DetailsViewModel: ObservableObject {
    
    var current: CurrentWeatherModel?
    var hourly: HourlyForecastModel?
    var daily: DailyForecastModel?
    @Published private(set) var status: LoadingState = .idle
    var lat: Double?
    var lon: Double?
    var networkDataManager = NetworkDataManager.shared
    var favoritesViewModel = FavoritesViewModel.shared
    
    init(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
    }
    
    func updateLocation(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
    }
    
    func getAllWeathers() async {
        self.current = nil
        self.hourly = nil
        self.daily = nil
        
        status = .loading
        do {
            async let currentFetch: CurrentWeatherModel? = networkDataManager.fetchWeather(lat: lat, lon: lon, endpoint: "weather")
            async let hourlyFetch: HourlyForecastModel? = networkDataManager.fetchWeather(lat: lat, lon: lon, cnt: 24, endpoint: "forecast/hourly")
            async let dailyFetch: DailyForecastModel? = networkDataManager.fetchWeather(lat: lat, lon: lon, cnt: 10, endpoint: "forecast/daily")
            
            let (currentData, hourlyData, dailyData) = try await (currentFetch, hourlyFetch, dailyFetch)
            
            self.current = currentData
            self.hourly = hourlyData
            self.daily = dailyData
            
            status = .success
        } catch {
            print("Error detail: \(error.localizedDescription)")
            status = .error(error)
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        return favoritesViewModel.isFavorite(id: id)
    }
    
    func toggleFavorite(location: SavedFavorite) {
        favoritesViewModel.toggleFavorite(location: location)
        self.objectWillChange.send()
    }
    
    func getSkyGradient(for period: DayPeriod) -> LinearGradient {
        switch period {
        case .night: return SkyGradients.nightGradient
        case .sunrise: return SkyGradients.sunriseGradient
        case .day: return SkyGradients.dayGradient
        case .sunset: return SkyGradients.sunsetGradient
        }
    }
}
