//
//  Extensions.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 15.12.2025.
//

import Foundation
import SwiftUI

extension Int {
    
    private static let cachedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    func toFormattedDate(_ format: String = "HH:mm", offset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = Self.cachedFormatter
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: offset)
        return formatter.string(from: date)
    }
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localized(with arguments: CVarArg...) -> String {
        String(format: self.localized, arguments: arguments)
    }
}

extension Color {
    static func appleWeatherColor(for temp: Double, unit: UnitTemperature = .celsius) -> Color {
        
        let inputMeasurement = Measurement(value: temp, unit: unit)
        let celsiusTemp = inputMeasurement.converted(to: .celsius).value
        
        let stops: [(temp: Double, color: Color)] = [
            (-20, .init(red: 0.2, green: 0.0, blue: 0.6)),
            (0,   .init(red: 0.0, green: 0.6, blue: 1.0)),
            (10,  .init(red: 0.0, green: 0.8, blue: 0.8)),
            (18,  .init(red: 0.4, green: 0.9, blue: 0.4)),
            (25,  .init(red: 1.0, green: 0.8, blue: 0.0)),
            (32,  .init(red: 1.0, green: 0.5, blue: 0.0)),
            (40,  .init(red: 1.0, green: 0.0, blue: 0.0))
        ]
        
        if celsiusTemp <= stops.first!.temp { return stops.first!.color }
        if celsiusTemp >= stops.last!.temp { return stops.last!.color }
        
        for i in 0..<stops.count - 1 {
            let stop1 = stops[i]
            let stop2 = stops[i+1]
            
            if celsiusTemp >= stop1.temp && celsiusTemp <= stop2.temp {
                let range = stop2.temp - stop1.temp
                let progress = (celsiusTemp - stop1.temp) / range
                return mixColors(from: stop1.color, to: stop2.color, percentage: progress)
            }
        }
        
        return .gray
    }
    
    private static func mixColors(from color1: Color, to color2: Color, percentage: Double) -> Color {
        let uiColor1 = UIColor(color1)
        let uiColor2 = UIColor(color2)
        
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return Color(
            red: r1 + (r2 - r1) * percentage,
            green: g1 + (g2 - g1) * percentage,
            blue: b1 + (b2 - b1) * percentage,
            opacity: a1 + (a2 - a1) * percentage
        )
    }
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
