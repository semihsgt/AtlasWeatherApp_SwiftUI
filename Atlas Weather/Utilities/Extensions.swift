//
//  Extensions.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 15.12.2025.
//

import Foundation

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
