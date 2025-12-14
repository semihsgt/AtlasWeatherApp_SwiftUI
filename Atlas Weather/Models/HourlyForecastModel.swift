//
//  HourlyForecastModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 12.12.2025.
//

import Foundation

nonisolated struct HourlyForecastModel: Decodable {
    let cod: String?
    let message, cnt: Int?
    let list: [ListHourly]?
    let city: CityHourly?
    
    static func mockData() -> HourlyForecastModel {
        let weather = WeatherHourly(id: 2, main: "d", description: "d", icon: "10d")
        let list = ListHourly(dt: 4, main: MainClassHourly(temp: 2, feelsLike: 3, tempMin: 3, tempMax: 3, pressure: 3, seaLevel: 3, grndLevel: 3, humidity: 3, tempKf: 3), weather: [weather,weather,weather,weather,weather,weather,weather,weather,weather,weather,weather,weather], clouds: CloudsHourly(all: 2), wind: WindHourly(speed: 2, deg: 2, gust: 2), rain: RainHourly(last1H: 2), snow: SnowHourly(last1H: 3), visibility: 3, pop: 1, sys: SysHourly(pod: "f"), dtTxt: "d")
        
        return HourlyForecastModel(cod: "tr", message: 1, cnt: 3, list: [list,list,list,list,list,list,list,list,list,list,list,list,list,list,list,list,list], city: CityHourly(id: 1, name: "d", coord: nil, country: "s", population: 1, timezone: 1, sunrise: 1, sunset: 1))
    }
}

struct CityHourly: Decodable {
    let id: Int?
    let name: String?
    let coord: CoordHourly?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

struct CoordHourly: Decodable {
    let lat, lon: Double?
}

struct ListHourly: Decodable {
    let dt: Int?
    let main: MainClassHourly?
    let weather: [WeatherHourly]?
    let clouds: CloudsHourly?
    let wind: WindHourly?
    let rain: RainHourly?
    let snow: SnowHourly?
    let visibility: Int?
    let pop: Double?
    let sys: SysHourly?
    let dtTxt: String?
}

struct CloudsHourly: Decodable {
    let all: Int?
}

struct MainClassHourly: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?
}

struct RainHourly: Decodable {
    let last1H: Double?
    
    enum CodingKeys: String, CodingKey {
        case last1H = "1h"
    }
}

struct SnowHourly: Decodable {
    let last1H: Double?
    
    enum CodingKeys: String, CodingKey {
        case last1H = "1h"
    }
}

struct SysHourly: Decodable {
    let pod: String?
}

struct WeatherHourly: Decodable {
    let id: Int?
    let main, description, icon: String?
}

struct WindHourly: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
