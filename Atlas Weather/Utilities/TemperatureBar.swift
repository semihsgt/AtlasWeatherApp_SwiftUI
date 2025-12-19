//
//  TemperatureBar.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 15.12.2025.
//

import SwiftUI

struct TemperatureBar: View {
    
    let dayMin: Double?
    let dayMax: Double?
    let globalMin: Double?
    let globalMax: Double?
    let currentTemp: Double?
    
    private var isValid: Bool {
        return dayMin != nil && dayMax != nil && globalMin != nil && globalMax != nil
    }
    
    func colorForTemperature(_ temp: Double, globalMin: Double, globalMax: Double) -> Color {
        let range = globalMax - globalMin
        guard range > 0 else { return .blue }
        let percent = min(max((temp - globalMin) / range, 0), 1)
        
        switch percent {
        case 0..<0.33:
            let p = percent / 0.33
            return Color(
                red: 0.0 + (0.0 * p),
                green: 0.8 - (0.1 * p),
                blue: 1.0 - (0.2 * p)
            )
        case 0.33..<0.66:
            let p = (percent - 0.33) / 0.33
            return Color(
                red: 0.0 + (0.2 * p),
                green: 0.7 + (0.1 * p),
                blue: 0.8 - (0.4 * p)
            )
        default:
            let p = (percent - 0.66) / 0.34
            return Color(
                red: 0.2 + (0.6 * p),
                green: 0.8 + (0.1 * p),
                blue: 0.4 - (0.4 * p)
            )
        }
    }
    
    var body: some View {
        if let dMin = dayMin, let dMax = dayMax,
           let gMin = globalMin, let gMax = globalMax {
            
            GeometryReader { geo in
                let validDayMin = min(dMin, dMax)
                let validDayMax = max(dMin, dMax)
                
                let range = gMax - gMin
                let safeRange = range > 0 ? range : 1.0
                
                let startPercent = min(max((validDayMin - gMin) / safeRange, 0), 1)
                let endPercent = min(max((validDayMax - gMin) / safeRange, 0), 1)
                
                let startColor = colorForTemperature(validDayMin, globalMin: gMin, globalMax: gMax)
                let endColor = colorForTemperature(validDayMax, globalMin: gMin, globalMax: gMax)
                
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 6)
                    
                    Capsule()
                        .fill(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
                        .frame(width: max(geo.size.width * (endPercent - startPercent), 0))
                        .offset(x: geo.size.width * startPercent)
                        .frame(height: 6)
                    
                    if let current = currentTemp {
                        let currentPercent = min(max((current - gMin) / safeRange, 0), 1)
                        Circle()
                            .fill(Color.white)
                            .overlay(Circle().stroke(Color.black.opacity(0.8), lineWidth: 0.5))
                            .frame(width: 8, height: 8)
                            .offset(x: (geo.size.width * currentPercent) - 4)
                            .shadow(radius: 1, y: 1)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 10)
            
        } else {
            Capsule()
                .fill(Color.gray.opacity(0.1))
                .frame(height: 6)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        Text("Valid Data:")
        TemperatureBar(dayMin: 15, dayMax: 25, globalMin: 10, globalMax: 30, currentTemp: 20)
            .frame(width: 300)
        
        Text("Placeholder:")
        TemperatureBar(dayMin: nil, dayMax: nil, globalMin: nil, globalMax: nil, currentTemp: nil)
            .frame(width: 300)
    }
}
