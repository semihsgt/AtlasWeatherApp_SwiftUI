//
//  Extensions.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 15.12.2025.
//

import Foundation

extension Int {
    func toFormattedDate(_ format: String = "HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
