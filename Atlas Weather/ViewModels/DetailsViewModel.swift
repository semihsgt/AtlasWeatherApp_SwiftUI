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
    let latitude: Double?
    let longitude: Double?
    
    init(latitude: Double?, longitude: Double?) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getAllWeathers() async {
        status = .loading
        do {
            async let currentFetch: CurrentWeatherModel? = NetworkDataManager.shared.fetchWeather(lat: latitude, lon: longitude, endpoint: "weather")
            async let hourlyFetch: HourlyForecastModel? = NetworkDataManager.shared.fetchWeather(lat: latitude, lon: longitude, cnt: 24, endpoint: "forecast/hourly")
            async let dailyFetch: DailyForecastModel? = NetworkDataManager.shared.fetchWeather(lat: latitude, lon: longitude, cnt: 10, endpoint: "forecast/daily")
            
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
        return FavoritesViewModel.shared.isFavorite(id: id)
    }
    
    func toggleFavorite(location: SavedFavorite) {
        FavoritesViewModel.shared.toggleFavorite(location: location)
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
