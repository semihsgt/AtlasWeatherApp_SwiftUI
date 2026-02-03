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
    var unit: UnitTemperature = .celsius
    
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
                
                let startColor = Color.appleWeatherColor(for: validDayMin, unit: unit)
                let endColor = Color.appleWeatherColor(for: validDayMax, unit: unit)
                
                ZStack(alignment: .leading) {
                    
                    Capsule()
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 7)
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [startColor, endColor],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(geo.size.width * (endPercent - startPercent), 0))
                        .offset(x: geo.size.width * startPercent)
                        .frame(height: 7)
                    
                    if let current = currentTemp {
                        let currentPercent = min(max((current - gMin) / safeRange, 0), 1)
                        
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 9, height: 9)
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 5, height: 5)
                            
                        }
                        .offset(x: (geo.size.width * currentPercent) - 4)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 10)
            
        } else {
            Capsule()
                .fill(Color.white.opacity(0.1))
                .frame(height: 7)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        Text("Valid Data:")
        TemperatureBar(dayMin: 25, dayMax: 35, globalMin: 20, globalMax: 40, currentTemp: 29)
            .frame(width: 300)
        
        Text("Placeholder:")
        TemperatureBar(dayMin: nil, dayMax: nil, globalMin: nil, globalMax: nil, currentTemp: nil)
            .frame(width: 300)
    }
    .foregroundStyle(.white)
    .frame(width: 410, height: 910)
    .background {
        SkyGradients.dayGradient
        ColorManager.backgroundColor()
    }
    
}
