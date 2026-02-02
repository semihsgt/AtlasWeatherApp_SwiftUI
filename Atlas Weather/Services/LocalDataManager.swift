//
//  LocalDataManager.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 10.12.2025.
//

import Foundation

final class LocalDataManager {
    
    private init() {
    }
    
    static let shared = LocalDataManager()
    var languageManager = LanguageManager.shared
    
    
    func loadCountries() async -> [CountryModel]? {
        let url: URL
        
        if languageManager.currentLanguage == "tr" {
            guard let trURL = Bundle.main.url(forResource: "Countries_TR", withExtension: "json") else {
                debugPrint("File Not Found")
                return []
            }
            url = trURL
        } else {
            guard let enURL = Bundle.main.url(forResource: "Countries_EN", withExtension: "json") else {
                debugPrint("File Not Found")
                return []
            }
            url = enURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CountryModel].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
    
    func loadCountriesForUnsplashSearch() async -> [CountryUnsplashModel]? {
        let url: URL
        
        guard let enURL = Bundle.main.url(forResource: "Countries_EN", withExtension: "json") else {
            debugPrint("File Not Found")
            return []
        }
        url = enURL
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CountryUnsplashModel].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
    
}


