//
//  DailyForecastModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

nonisolated struct DailyForecastModel: Decodable {
    let city: CityDaily?
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [ListDaily]?
}

struct CityDaily: Decodable {
    let id: Int?
    let name: String?
    let coord: CoordDaily?
    let country: String?
    let population, timezone: Int?
}

struct CoordDaily: Decodable {
    let lon, lat: Double?
}

struct ListDaily: Decodable {
    let dt, sunrise, sunset: Int?
    let temp: TempDaily?
    let feelsLike: FeelsLikeDaily?
    let pressure, humidity: Int?
    let weather: [WeatherDaily]?
    let speed: Double?
    let deg: Int?
    let gust: Double?
    let clouds: Int?
    let rain, snow: Double?
    let pop: Double?
}

struct FeelsLikeDaily: Decodable {
    let day, night, eve, morn: Double?
}

struct TempDaily: Decodable {
    let day, min, max, night: Double?
    let eve, morn: Double?
}

struct WeatherDaily: Decodable {
    let id: Int?
    let main, description, icon: String?
}
