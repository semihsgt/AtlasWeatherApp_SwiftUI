//
//  GeocodingModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

typealias GeocodingModel = [GeocodingItem]

nonisolated struct GeocodingItem: Codable {
    let name: String?
    let localNames: [String: String]?
    let lat, lon: Double?
    let country, state: String?
}
