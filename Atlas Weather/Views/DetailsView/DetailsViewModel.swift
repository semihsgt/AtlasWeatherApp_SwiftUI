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
final class DetailsViewModel: ObservableObject {
    
    init(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
    }
    
    var lat: Double?
    var lon: Double?
    
    var current: CurrentWeatherModel?
    var hourly: HourlyForecastModel?
    var daily: DailyForecastModel?
    
    private var countries: [CountryModel]?
    var country: CountryModel?
    var isCountryAvaliable: Bool?
    
    @Published private(set) var status: LoadingState = .idle
    private var networkDataManager = NetworkDataManager.shared
    private var favoritesViewModel = FavoritesViewModel.shared
    private var localDataManager = LocalDataManager.shared
    private var lastCache : WeatherCache?
    @AppStorage("selected_unit") private var selectedUnit: Unit = .metric
    private var lastFetchedUnit: Unit?
    
    func getAllWeathers() async {
        
        if let cache = lastCache, let currentLat = lat, let currentLon = lon {
            let isLocationSame = abs(cache.lat - currentLat) < 0.01 && abs(cache.lon - currentLon) < 0.01
            let timeDiff = Date().timeIntervalSince(cache.timestamp)
            
            if isLocationSame && timeDiff < 600 && lastFetchedUnit == selectedUnit {
                debugPrint("CACHE IS IN USE: DID NOT CALL THE API (Call age: \(Int(timeDiff)) sec)")
                
                self.current = cache.current
                self.hourly = cache.hourly
                self.daily = cache.daily
                self.country = cache.country
                self.isCountryAvaliable = cache.isCountryAvailable
                
                self.status = .success
                return
            }
        }
        
        self.current = nil
        self.hourly = nil
        self.daily = nil
        self.countries = nil
        self.country = nil
        
        status = .loading
        do {
            async let currentFetch: CurrentWeatherModel? = networkDataManager.fetchWeather(lat: lat, lon: lon, endpoint: "weather")
            async let hourlyFetch: HourlyForecastModel? = networkDataManager.fetchWeather(lat: lat, lon: lon, cnt: 24, endpoint: "forecast/hourly")
            async let dailyFetch: DailyForecastModel? = networkDataManager.fetchWeather(lat: lat, lon: lon, cnt: 10, endpoint: "forecast/daily")
            async let countriesFetch: [CountryModel]? = localDataManager.loadCountries()
            
            let (currentData, hourlyData, dailyData, countriesData) = try await (currentFetch, hourlyFetch, dailyFetch, countriesFetch)
            
            self.current = currentData
            self.hourly = hourlyData
            self.daily = dailyData
            self.countries = countriesData
            self.isCountryAvaliable = getCountry()
            
            if let safeLat = lat, let safeLon = lon {
                
                self.lastFetchedUnit = selectedUnit
                self.lastCache = WeatherCache(
                    current: currentData,
                    hourly: hourlyData,
                    daily: dailyData,
                    country: self.country,
                    isCountryAvailable: self.isCountryAvaliable,
                    timestamp: Date(),
                    lat: safeLat,
                    lon: safeLon
                )
                debugPrint("NEW DATA CACHED: \(Date().formatted())")
            }
            
            status = .success
            
        } catch {
            debugPrint("Error detail: \(error.localizedDescription)")
            status = .error(error)
        }
    }
    
    private func getCountry() -> Bool? {
        return countries?.contains { country in
            if country.id == current?.sys?.country {
                self.country = country
                return true
            } else {
                return false
            }
        }
    }
    
    
    func updateLocation(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
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
