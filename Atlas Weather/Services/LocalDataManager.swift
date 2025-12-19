//
//  LocalDataManager.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 10.12.2025.
//

import Foundation

class LocalDataManager {
    
    private init() {
    }
    
    static let shared = LocalDataManager()
    
    func loadCountries() async throws -> [CountryModel] {
        
        guard let url = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            throw LocalJsonDataErrors.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CountryModel].self, from: data)
        } catch let decodingError as DecodingError {
            throw LocalJsonDataErrors.decodingFailed(underlyingError: decodingError)
        } catch {
            throw LocalJsonDataErrors.localFileReadError(underlyingError: error)
        }
    }
}
