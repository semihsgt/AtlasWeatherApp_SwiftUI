//
//  TemperatureBar.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 15.12.2025.
//

import SwiftUI

struct TemperatureBar: View {
    let dayMin: Double
    let dayMax: Double
    let globalMin: Double
    let globalMax: Double
    let currentTemp: Double?
    
    func colorForTemperature(_ temp: Double) -> Color {
        let range = globalMax - globalMin
        guard range > 0 else { return .teal }
        let percent = (temp - globalMin) / range
        
        switch percent {
        case 0..<0.33:
            // Cyan'dan Teal'a
            let p = percent / 0.33
            return Color(
                red: 0.0 + (0.0 * p),
                green: 0.8 - (0.1 * p),
                blue: 1.0 - (0.2 * p)
            )
        case 0.33..<0.66:
            // Teal'dan Green'e
            let p = (percent - 0.33) / 0.33
            return Color(
                red: 0.0 + (0.2 * p),
                green: 0.7 + (0.1 * p),
                blue: 0.8 - (0.4 * p)
            )
        default:
            // Green'den Yellow-Green'e
            let p = (percent - 0.66) / 0.34
            return Color(
                red: 0.2 + (0.3 * p),
                green: 0.8 + (0.1 * p),
                blue: 0.4 - (0.2 * p)
            )
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            let range = globalMax - globalMin
            let startPercent = range > 0 ? (dayMin - globalMin) / range : 0
            let endPercent = range > 0 ? (dayMax - globalMin) / range : 1
            let startColor = colorForTemperature(dayMin)
            let endColor = colorForTemperature(dayMax)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [startColor, endColor],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * (endPercent - startPercent))
                    .offset(x: geo.size.width * startPercent)
                
                if let current = currentTemp {
                    let currentPercent = range > 0 ? (current - globalMin) / range : 0.5
                    Circle()
                        .fill(Color.white)
                        .overlay(content: {
                            Circle().stroke(.black, lineWidth: 0.5)
                        })
                        .frame(width: 6, height: 6)
                        .offset(x: geo.size.width * currentPercent - 3)
                }
            }
        }
        .frame(height: 6)
    }
}

#Preview {
    TemperatureBar(dayMin: 4, dayMax: 10, globalMin: -4, globalMax: 13, currentTemp: 5)
        .frame(width: 300)
    TemperatureBar(dayMin: -2, dayMax: 13, globalMin: -4, globalMax: 13, currentTemp: nil)
        .frame(width: 300)
}
