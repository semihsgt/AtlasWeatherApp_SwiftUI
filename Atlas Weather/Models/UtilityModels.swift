//
//  UtilityModels.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

enum TimeFormat: String, CaseIterable {
    case twelveHour = "12h"
    case twentyFourHour = "24h"
    
    var displayName: String {
        switch self {
        case .twelveHour:
            return String(localized: "time_format_12")
        case .twentyFourHour:
            return String(localized: "time_format_24")
        }
    }
}

enum Unit: String, CaseIterable {
    case standard
    case metric
    case imperial
    
    var displayName: String {
        switch self {
        case .standard:
            return String(localized: "unit_standard")
        case .metric:
            return String(localized: "unit_metric")
        case .imperial:
            return String(localized: "unit_imperial")
        }
    }
}

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
