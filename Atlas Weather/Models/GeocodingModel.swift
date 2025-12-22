//
//  GeocodingModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

nonisolated struct GeocodingModel: Decodable, Identifiable {
    var id = UUID()
    let name: String?
    let localNames: [String: String]?
    let lat, lon: Double?
    let country, state: String?
    
    enum CodingKeys: CodingKey {
        case name
        case localNames
        case lat
        case lon
        case country
        case state
    }
}
