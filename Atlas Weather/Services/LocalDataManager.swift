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
            throw LocalJsonErrors.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CountryModel].self, from: data)
        } catch let decodingError as DecodingError {
            throw LocalJsonErrors.decodingFailed(underlyingError: decodingError)
        } catch {
            throw LocalJsonErrors.localFileReadError(underlyingError: error)
        }
    }
}
