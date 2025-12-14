//
//  DetailsViewModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

struct WeatherDetails {
    let current: CurrentWeatherModel
    let hourly: HourlyForecastModel
    let daily: DailyForecastModel
}

@MainActor
@Observable
class DetailsViewModel {
    private(set) var status: LoadingState<WeatherDetails> = .idle
    
    func getAllDetails() async {
        status = .loading
        do {
            async let current: CurrentWeatherModel = NetworkDataManager.shared.fetchWeather(lat: 39.93117123855586, lon: 32.857508333355966, endpoint: "weather")
            async let hourly: HourlyForecastModel = NetworkDataManager.shared.fetchWeather(lat: 39.93117123855586, lon: 32.857508333355966,cnt: 24, endpoint: "forecast/hourly")
            async let daily: DailyForecastModel = NetworkDataManager.shared.fetchWeather(lat: 39.93117123855586, lon: 32.857508333355966,cnt: 10, endpoint: "forecast/daily")
            
            let (currentData, hourlyData, dailyData) = try await (current, hourly, daily)
            let details = WeatherDetails( current: currentData, hourly: hourlyData, daily: dailyData)
            status = .success(details)
        } catch {
            print(error)
            status = .error(error)
        }
    }
}
