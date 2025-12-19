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
        let hour1 = ListHourly(
            dt: 1734354000,
            main: MainClassHourly(temp: 8.2, feelsLike: 6.1, tempMin: 7.5, tempMax: 8.2, pressure: 1015, seaLevel: 1015, grndLevel: 1012, humidity: 72, tempKf: 0.5),
            weather: [WeatherHourly(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")],
            clouds: CloudsHourly(all: 92),
            wind: WindHourly(speed: 3.8, deg: 215, gust: 6.2),
            rain: nil,
            snow: nil,
            visibility: 10000,
            pop: 0.12,
            sys: SysHourly(pod: "d"),
            dtTxt: "2024-12-16 12:00:00"
        )
        
        let hour2 = ListHourly(
            dt: 1734357600,
            main: MainClassHourly(temp: 9.1, feelsLike: 7.2, tempMin: 8.8, tempMax: 9.1, pressure: 1014, seaLevel: 1014, grndLevel: 1011, humidity: 68, tempKf: 0.3),
            weather: [WeatherHourly(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")],
            clouds: CloudsHourly(all: 78),
            wind: WindHourly(speed: 4.1, deg: 220, gust: 7.0),
            rain: nil,
            snow: nil,
            visibility: 10000,
            pop: 0.08,
            sys: SysHourly(pod: "d"),
            dtTxt: "2024-12-16 13:00:00"
        )
        
        let hour3 = ListHourly(
            dt: 1734361200,
            main: MainClassHourly(temp: 9.5, feelsLike: 7.8, tempMin: 9.2, tempMax: 9.5, pressure: 1013, seaLevel: 1013, grndLevel: 1010, humidity: 65, tempKf: 0.2),
            weather: [WeatherHourly(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")],
            clouds: CloudsHourly(all: 45),
            wind: WindHourly(speed: 3.5, deg: 200, gust: 5.8),
            rain: nil,
            snow: nil,
            visibility: 10000,
            pop: 0.05,
            sys: SysHourly(pod: "d"),
            dtTxt: "2024-12-16 14:00:00"
        )
        
        let hour4 = ListHourly(
            dt: 1734364800,
            main: MainClassHourly(temp: 8.8, feelsLike: 6.9, tempMin: 8.5, tempMax: 8.8, pressure: 1013, seaLevel: 1013, grndLevel: 1010, humidity: 70, tempKf: 0.1),
            weather: [WeatherHourly(id: 801, main: "Clouds", description: "few clouds", icon: "02d")],
            clouds: CloudsHourly(all: 22),
            wind: WindHourly(speed: 4.0, deg: 195, gust: 6.5),
            rain: nil,
            snow: nil,
            visibility: 10000,
            pop: 0.02,
            sys: SysHourly(pod: "d"),
            dtTxt: "2024-12-16 15:00:00"
        )
        
        let hour5 = ListHourly(
            dt: 1734368400,
            main: MainClassHourly(temp: 7.5, feelsLike: 5.2, tempMin: 7.2, tempMax: 7.5, pressure: 1014, seaLevel: 1014, grndLevel: 1011, humidity: 75, tempKf: 0.0),
            weather: [WeatherHourly(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
            clouds: CloudsHourly(all: 8),
            wind: WindHourly(speed: 4.2, deg: 210, gust: 7.1),
            rain: nil,
            snow: nil,
            visibility: 10000,
            pop: 0.0,
            sys: SysHourly(pod: "d"),
            dtTxt: "2024-12-16 16:00:00"
        )
        
        let hour6 = ListHourly(
            dt: 1734372000,
            main: MainClassHourly(temp: 6.8, feelsLike: 4.3, tempMin: 6.5, tempMax: 6.8, pressure: 1015, seaLevel: 1015, grndLevel: 1012, humidity: 78, tempKf: 0.0),
            weather: [WeatherHourly(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
            clouds: CloudsHourly(all: 12),
            wind: WindHourly(speed: 3.8, deg: 215, gust: 6.5),
            rain: nil,
            snow: nil,
            visibility: 10000,
            pop: 0.0,
            sys: SysHourly(pod: "d"),
            dtTxt: "2024-12-16 17:00:00"
        )
        
        return HourlyForecastModel(
            cod: "200",
            message: 0,
            cnt: 12,
            list: [hour1, hour2, hour3, hour4, hour5, hour6],
            city: CityHourly(
                id: 745044,
                name: "Istanbul",
                coord: CoordHourly(lat: 41.0082, lon: 28.9784),
                country: "TR",
                population: 15460000,
                timezone: 10800,
                sunrise: 1734326580,
                sunset: 1734359940
            )
        )
    }
}

extension HourlyForecastModel {
    
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

}
