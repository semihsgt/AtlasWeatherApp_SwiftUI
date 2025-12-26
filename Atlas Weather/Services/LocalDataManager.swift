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
    
    func loadCountries() async -> [CountryModel] {
        
        guard let url = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            debugPrint("File Not Found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CountryModel].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
}
