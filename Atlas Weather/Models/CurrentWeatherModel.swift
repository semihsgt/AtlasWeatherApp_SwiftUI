//
//  CurrentWeather.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 12.12.2025.
//

import Foundation

nonisolated struct CurrentWeatherModel: Decodable {
    let coord: CoordCurrent?
    let weather: [WeatherCurrent]?
    let base: String?
    let main: MainCurrent?
    let visibility: Int?
    let wind: WindCurrent?
    let clouds: CloudsCurrent?
    let dt: Int?
    let sys: SysCurrent?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

struct CloudsCurrent: Decodable {
    let all: Int?
}

struct CoordCurrent: Decodable {
    let lon, lat: Double?
}

struct MainCurrent: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?
}

struct SysCurrent: Decodable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

struct WeatherCurrent: Decodable {
    let id: Int?
    let main, description, icon: String?
}

struct WindCurrent: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
