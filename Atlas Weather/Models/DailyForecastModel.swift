//
//  DailyForecastModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

nonisolated struct DailyForecastModel: Decodable {
    let city: CityDaily
    let cod: String
    let message: Double
    let cnt: Int
    let list: [ListDaily]
    
    static func MockData() -> DailyForecastModel {
        let list1 = ListDaily(dt: 1734256800, sunrise: 1734241200, sunset: 1734273600, temp: TempDaily(day: 8, min: 3, max: 10, night: 4, eve: 6, morn: 3), feelsLike: FeelsLikeDaily(day: 6, night: 2, eve: 4, morn: 1), pressure: 1015, humidity: 75, weather: [WeatherDaily(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")], speed: 4.2, deg: 220, gust: 7.5, clouds: 90, rain: nil, snow: nil, pop: 0.2)
        
        let list2 = ListDaily(dt: 1734343200, sunrise: 1734327600, sunset: 1734360000, temp: TempDaily(day: 11, min: 5, max: 13, night: 7, eve: 9, morn: 5), feelsLike: FeelsLikeDaily(day: 9, night: 5, eve: 7, morn: 3), pressure: 1012, humidity: 68, weather: [WeatherDaily(id: 800, main: "Clear", description: "clear sky", icon: "01d")], speed: 3.1, deg: 180, gust: 5.2, clouds: 5, rain: nil, snow: nil, pop: 0.0)
        
        let list3 = ListDaily(dt: 1734429600, sunrise: 1734414000, sunset: 1734446400, temp: TempDaily(day: 6, min: 2, max: 8, night: 3, eve: 5, morn: 2), feelsLike: FeelsLikeDaily(day: 3, night: 0, eve: 2, morn: -1), pressure: 1020, humidity: 82, weather: [WeatherDaily(id: 500, main: "Rain", description: "light rain", icon: "10d")], speed: 5.8, deg: 270, gust: 9.3, clouds: 75, rain: 2.5, snow: nil, pop: 0.85)
        
        let list4 = ListDaily(dt: 1734516000, sunrise: 1734500400, sunset: 1734532800, temp: TempDaily(day: 4, min: 0, max: 6, night: 1, eve: 3, morn: 0), feelsLike: FeelsLikeDaily(day: 1, night: -3, eve: 0, morn: -4), pressure: 1025, humidity: 70, weather: [WeatherDaily(id: 801, main: "Clouds", description: "few clouds", icon: "02d")], speed: 6.2, deg: 315, gust: 10.1, clouds: 20, rain: nil, snow: nil, pop: 0.1)
        
        let list5 = ListDaily(dt: 1734602400, sunrise: 1734586800, sunset: 1734619200, temp: TempDaily(day: 2, min: -2, max: 4, night: -1, eve: 1, morn: -2), feelsLike: FeelsLikeDaily(day: -2, night: -5, eve: -3, morn: -6), pressure: 1028, humidity: 65, weather: [WeatherDaily(id: 600, main: "Snow", description: "light snow", icon: "13d")], speed: 4.5, deg: 45, gust: 7.8, clouds: 85, rain: nil, snow: 1.2, pop: 0.65)
        
        let list6 = ListDaily(dt: 1734688800, sunrise: 1734673200, sunset: 1734705600, temp: TempDaily(day: -1, min: -5, max: 1, night: -4, eve: -2, morn: -5), feelsLike: FeelsLikeDaily(day: -5, night: -9, eve: -6, morn: -10), pressure: 1030, humidity: 60, weather: [WeatherDaily(id: 800, main: "Clear", description: "clear sky", icon: "01d")], speed: 2.8, deg: 90, gust: 4.5, clouds: 0, rain: nil, snow: nil, pop: 0.0)
        
        let list7 = ListDaily(dt: 1734775200, sunrise: 1734759600, sunset: 1734792000, temp: TempDaily(day: 3, min: -2, max: 5, night: 0, eve: 2, morn: -2), feelsLike: FeelsLikeDaily(day: 0, night: -4, eve: -1, morn: -6), pressure: 1022, humidity: 72, weather: [WeatherDaily(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")], speed: 3.5, deg: 135, gust: 6.0, clouds: 65, rain: nil, snow: nil, pop: 0.15)
        
        let list8 = ListDaily(dt: 1734861600, sunrise: 1734846000, sunset: 1734878400, temp: TempDaily(day: 7, min: 2, max: 9, night: 4, eve: 6, morn: 2), feelsLike: FeelsLikeDaily(day: 5, night: 1, eve: 4, morn: -1), pressure: 1018, humidity: 78, weather: [WeatherDaily(id: 501, main: "Rain", description: "moderate rain", icon: "10d")], speed: 4.8, deg: 200, gust: 8.2, clouds: 95, rain: 5.8, snow: nil, pop: 0.92)
        
        let list9 = ListDaily(dt: 1734948000, sunrise: 1734932400, sunset: 1734964800, temp: TempDaily(day: 9, min: 4, max: 11, night: 6, eve: 8, morn: 4), feelsLike: FeelsLikeDaily(day: 7, night: 4, eve: 6, morn: 2), pressure: 1014, humidity: 70, weather: [WeatherDaily(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")], speed: 3.2, deg: 160, gust: 5.5, clouds: 40, rain: nil, snow: nil, pop: 0.05)
        
        let list10 = ListDaily(dt: 1735034400, sunrise: 1735018800, sunset: 1735051200, temp: TempDaily(day: 12, min: 6, max: 14, night: 8, eve: 10, morn: 6), feelsLike: FeelsLikeDaily(day: 10, night: 6, eve: 8, morn: 4), pressure: 1010, humidity: 65, weather: [WeatherDaily(id: 800, main: "Clear", description: "clear sky", icon: "01d")], speed: 2.5, deg: 180, gust: 4.0, clouds: 10, rain: nil, snow: nil, pop: 0.0)
        
        return DailyForecastModel(
            city: CityDaily(id: 745044, name: "Istanbul", coord: CoordDaily(lon: 28.9784, lat: 41.0082), country: "TR", population: 15460000, timezone: 10800),
            cod: "200",
            message: 0.0582563,
            cnt: 10,
            list: [list1, list2, list3, list4, list5, list6, list7, list8, list9, list10]
        )
    }
}

struct CityDaily: Decodable {
    let id: Int
    let name: String
    let coord: CoordDaily
    let country: String
    let population, timezone: Int
}

struct CoordDaily: Decodable {
    let lon, lat: Double
}

struct ListDaily: Decodable {
    let dt, sunrise, sunset: Int
    let temp: TempDaily
    let feelsLike: FeelsLikeDaily
    let pressure, humidity: Int
    let weather: [WeatherDaily]
    let speed: Double
    let deg: Int
    let gust: Double?
    let clouds: Int
    let rain, snow: Double?
    let pop: Double
}

struct FeelsLikeDaily: Decodable {
    let day, night, eve, morn: Double
}

struct TempDaily: Decodable {
    let day, min, max, night: Double
    let eve, morn: Double
}

struct WeatherDaily: Decodable {
    let id: Int
    let main, description, icon: String
}
