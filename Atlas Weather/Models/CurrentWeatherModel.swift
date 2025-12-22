//
//  CurrentWeather.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 12.12.2025.
//

import Foundation

nonisolated struct CurrentWeatherModel: Decodable, Identifiable {
    let coord: CoordCurrent?
    let weather: [WeatherCurrent]?
    let base: String?
    let main: MainCurrent?
    let visibility: Int?
    let wind: WindCurrent?
    let clouds: CloudsCurrent?
    let rain: RainCurrent?
    let snow: SnowCurrent?
    let dt: Int?
    let sys: SysCurrent?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
    
    static func MockData() -> CurrentWeatherModel {
        let weather = WeatherCurrent(
            id: 801,
            main: "Clouds",
            description: "parçalı bulutlu",
            icon: "02d"
        )
        
        return CurrentWeatherModel(
            coord: CoordCurrent(lon: 28.9784, lat: 41.0082),
            weather: [weather],
            base: "stations",
            main: MainCurrent(
                temp: 18.5,
                feelsLike: 17.8,
                tempMin: 16.2,
                tempMax: 21.3,
                pressure: 1015,
                humidity: 65,
                seaLevel: 1015,
                grndLevel: 1012
            ),
            visibility: 10000,
            wind: WindCurrent(speed: 3.6, deg: 180, gust: 5.2),
            clouds: CloudsCurrent(all: 40),
            rain: nil,
            snow: nil,
            dt: 1702818000,
            sys: SysCurrent(
                type: 2,
                id: 6970,
                country: "TR",
                sunrise: 1702790400,
                sunset: 1702824000
            ),
            timezone: 10800,
            id: 745044,
            name: "İstanbul",
            cod: 200
        )
    }
}

extension CurrentWeatherModel {
    
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
    
    struct RainCurrent: Decodable {
        let last1H: Double?
        
        enum CodingKeys: String, CodingKey {
            case last1H = "1h"
        }
    }
    
    struct SnowCurrent: Decodable {
        let last1H: Double?
        
        enum CodingKeys: String, CodingKey {
            case last1H = "1h"
        }
    }
}
