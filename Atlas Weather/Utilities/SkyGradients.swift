//
//  SkyGradients.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 24.12.2025.
//

import Foundation
import SwiftUI

struct SkyGradients {
    
    static let dayGradient = LinearGradient(
        colors: [
            Color(hex: "6DB9D6"),
            Color(hex: "1E90FF"),
            Color(hex: "4169E1")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let nightGradient = LinearGradient(
        colors: [
            Color(hex: "0C1445"),
            Color(hex: "1A237E"),
            Color(hex: "283593")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let sunriseGradient = LinearGradient(
        colors: [
            Color(hex: "355C7D"),
            Color(hex: "F67280"),
            Color(hex: "F8B500")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let sunsetGradient = LinearGradient(
        colors: [
            Color(hex: "2C3E50"),
            Color(hex: "E74C3C"),
            Color(hex: "F39C12")
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
