//
//  Country.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 10.12.2025.
//

import Foundation

struct CountryModel: Decodable, Identifiable {
    let id: String
    let name: String
    let capital: [String]
    let population: Int
    let flagURL: String
    let summary: String
    let currencies: Currency
    let region: String
    let subregion: String
    let languages: [String]
    let flag: String
    let timezones: [String]
    let drivingSide: String
    let capitalLocation: CapitalLocation
    let startOfWeek: String
    let demonym: String
    let independent: Bool
}

extension CountryModel {
    
    struct Currency: Decodable {
        let currencyCode: String
        let symbol: String
        let name: String
    }

    struct CapitalLocation: Decodable {
        let latitude: Double
        let longitude: Double
    }
}
