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
    
    static func mockData() -> CountryModel {
        CountryModel(
            id: "LU",
            name: "Luxembourg",
            capital: ["Luxembourg City"],
            population: 632275,
            flagURL: "https://flagcdn.com/w640/lu.png",
            summary: "Luxembourg is a small, wealthy European nation known for its medieval fortifications, banking sector, and role hosting EU institutions. Luxembourgers speak three languages (Luxembourgish, French, German) and enjoy one of the world's highest GDPs per capita. The country offers stunning old town gorges, wine regions along the Moselle, castle-dotted countryside, and excellent quality of life.",
            currencies: Currency(
                currencyCode: "EUR",
                symbol: "€",
                name: "Euro"
            ),
            region: "Europe",
            subregion: "Western Europe",
            languages: ["French", "German", "Luxembourgish"],
            flag: "🇱🇺",
            timezones: ["UTC+01:00"],
            drivingSide: "right",
            capitalLocation: CapitalLocation(
                latitude: 49.6116,
                longitude: 6.1319
            ),
            startOfWeek: "monday",
            demonym: "Luxembourger",
            independent: true
        )
    }
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


struct CountryUnsplashModel: Decodable, Identifiable {
    let id: String?
    let name: String?
}
