//
//  Errors.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 10.12.2025.
//

import Foundation

struct ErrorResponseModel: Decodable {
    let cod: Int?
    let message: String?
}

enum LocalJsonDataErrors: Error, LocalizedError {
    case fileNotFound
    case decodingFailed(underlyingError: Error)
    case localFileReadError(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Country JSON file not found in app bundle."
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode country data: \(error.localizedDescription)"
        case .localFileReadError(underlyingError: let error):
            return "Failed to read country data file: \(error.localizedDescription)"
        }
    }
}

enum NetworkErrors: Error, LocalizedError {
    case urlBuildFailed
    case requestFailed
    case clientError(Int, String)
    case serverError(String)
    case decodingFailed(String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .urlBuildFailed:
            return "Failed to build URL request."
        case .requestFailed:
            return "Network request failed."
        case .clientError(let code, let message):
            return "Error: \(code). Message: \(message)"
        case .serverError(let message):
            return "Server error: \(message)"
        case .decodingFailed(let message):
            return "Failed to decode response: \(message)"
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}

