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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct SkyGradients {
    
    static let dayGradient = LinearGradient(
        colors: [
            Color(hex: "6DB9D6"),
            Color(hex: "1E90FF"),
            Color(hex: "4169E1")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let nightGradient = LinearGradient(
        colors: [
            Color(hex: "0C1445"),
            Color(hex: "1A237E"),
            Color(hex: "283593")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let sunriseGradient = LinearGradient(
        colors: [
            Color(hex: "355C7D"),
            Color(hex: "F67280"),
            Color(hex: "F8B500")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let sunsetGradient = LinearGradient(
        colors: [
            Color(hex: "2C3E50"),
            Color(hex: "E74C3C"),
            Color(hex: "F39C12")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
