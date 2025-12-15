//
//  CurrentWeather.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 12.12.2025.
//

import Foundation

nonisolated struct CurrentWeatherModel: Decodable {
    let coord: CoordCurrent
    let weather: [WeatherCurrent]
    let base: String
    let main: MainCurrent
    let visibility: Int
    let wind: WindCurrent
    let clouds: CloudsCurrent
    let rain: RainCurrent?
    let snow: SnowCurrent?
    let dt: Int
    let sys: SysCurrent
    let timezone, id: Int
    let name: String
    let cod: Int
    
    static func MockData() -> CurrentWeatherModel {
        let list = WeatherCurrent(id: 1, main: "", description: "", icon: "")
        
        return CurrentWeatherModel(coord: CoordCurrent(lon: 1, lat: 1), weather: [list,list], base: "", main: MainCurrent(temp: 1, feelsLike: 1, tempMin: 1, tempMax: 1, pressure: 1, humidity: 1, seaLevel: 1, grndLevel: 1), visibility: 1, wind: WindCurrent(speed: 1, deg: 1, gust: 1), clouds: CloudsCurrent(all: 1), rain: RainCurrent(last1H: 1), snow: SnowCurrent(last1H: 1), dt: 1, sys: SysCurrent(type: 1, id: 1, country: "", sunrise: 1, sunset: 1), timezone: 1, id: 1, name: "", cod: 1)
    }
}

struct CloudsCurrent: Decodable {
    let all: Int
}

struct CoordCurrent: Decodable {
    let lon, lat: Double
}

struct MainCurrent: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int
}

struct SysCurrent: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct WeatherCurrent: Decodable {
    let id: Int
    let main, description, icon: String
}

struct WindCurrent: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct RainCurrent: Decodable {
    let last1H: Double
    
    enum CodingKeys: String, CodingKey {
        case last1H = "1h"
    }
}

struct SnowCurrent: Decodable {
    let last1H: Double
    
    enum CodingKeys: String, CodingKey {
        case last1H = "1h"
    }
}
