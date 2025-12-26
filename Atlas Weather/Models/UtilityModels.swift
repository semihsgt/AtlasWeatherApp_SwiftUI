//
//  UtilityModels.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case success
    case error(Error)
}

enum DayPeriod {
    case night
    case sunrise
    case day
    case sunset
}

extension DayPeriod {
    static func determine(sunrise: Int?, sunset: Int?, currentTime: Int?) -> DayPeriod {
        let duration = 2700
        
        guard let sunrise, let sunset, let currentTime else {
            return .day
        }
        
        let sunriseEnd = sunrise + duration
        let sunsetStart = sunset - duration
        
        if currentTime >= sunrise && currentTime < sunriseEnd {
            return .sunrise
        } else if currentTime >= sunsetStart && currentTime < sunset {
            return .sunset
        } else if currentTime >= sunriseEnd && currentTime < sunsetStart {
            return .day
        } else {
            return .night
        }
    }
}
