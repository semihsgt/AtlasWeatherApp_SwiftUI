//
//  UnsplashModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 2.02.2026.
//

import Foundation

struct UnsplashModel: Decodable {
    let results: [Photo]
    
    struct Photo: Codable {
        let urls: PhotoURL
    }
    
    struct PhotoURL: Codable {
        let regular: String
    }
}


