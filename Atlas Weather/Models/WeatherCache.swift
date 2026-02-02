//
//  WeatherCache.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 24.12.2025.
//

import Foundation

struct WeatherCache {
    let current: CurrentWeatherModel?
    let hourly: HourlyForecastModel?
    let daily: DailyForecastModel?
    let country: CountryModel?
    let timestamp: Date
    let lat: Double
    let lon: Double
}
