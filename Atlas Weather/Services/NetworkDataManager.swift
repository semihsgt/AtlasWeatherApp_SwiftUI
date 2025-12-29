//
//  NetworkDataManager.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 12.12.2025.
//
// https://pro.openweathermap.org/data/2.5/weather
// https://pro.openweathermap.org/data/2.5/forecast/hourly
// https://pro.openweathermap.org/data/2.5/forecast/daily
// https://pro.openweathermap.org/geo/1.0/direct

import Foundation

final class NetworkDataManager {
    
    private init() {
    }
    
    static let shared = NetworkDataManager()
    
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    
    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkErrors.requestFailed
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkErrors.decodingFailed(error.localizedDescription)
            }
        case 400...499:
            let errorResponse = try? decoder.decode(ErrorResponseModel.self, from: data)
            throw NetworkErrors.clientError(httpResponse.statusCode, errorResponse?.message ?? "Client Error")
        case 500...599:
            let errorResponse = try? decoder.decode(ErrorResponseModel.self, from: data)
            throw NetworkErrors.serverError(errorResponse?.message ?? "Server Error")
        default:
            throw NetworkErrors.unknown
        }
    }
    
    private func buildUrl(path: String? = nil, version: String? = nil, endpoint: String, queryItems: [URLQueryItem]) throws -> URL {
        guard let url = URL(string: "https://\(Secrets.subDomain).openweathermap.org")?
            .appending(path: path ?? "data")
            .appending(path: version ?? "2.5")
            .appending(path: endpoint)
            .appending(queryItems: queryItems) else {
            throw NetworkErrors.urlBuildFailed
        }
        return url
    }
    
    func fetchWeather<T: Decodable>(lat: Double? = nil, lon: Double? = nil, id: Int? = nil, units: String = "metric", cnt: Int? = nil, endpoint: String) async throws -> T? {
        
        guard (lat != nil && lon != nil) || id != nil else {
            return nil
        }
        
        var queryItems = [
            URLQueryItem(name: "appid", value: Secrets.apiKey),
            URLQueryItem(name: "units", value: units),
        ]
        if let id = id {
            queryItems.append(URLQueryItem(name: "id", value: String(id)))
        }
        if let lat = lat, let lon = lon {
            queryItems.append(URLQueryItem(name: "lat", value: String(lat)))
            queryItems.append(URLQueryItem(name: "lon", value: String(lon)))
        }
        if let cnt = cnt {
            queryItems.append(URLQueryItem(name: "cnt", value: String(cnt)))
        }
        let url = try buildUrl(endpoint: endpoint, queryItems: queryItems)
        return try await performRequest(url: url)
    }
    
    func fetchGeocoding(q: String) async throws -> [GeocodingModel] {
        let queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "appid", value: Secrets.apiKey),
            URLQueryItem(name: "limit", value: "10"),
        ]
        let url = try buildUrl(path: "geo", version: "1.0", endpoint: "direct", queryItems: queryItems)
        return try await performRequest(url: url)
    }
}
