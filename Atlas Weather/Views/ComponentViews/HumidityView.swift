//
//  HumidityView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct HumidityView: View {
    let humidity: Int?
    let currentTemp: Double?
    
    var dewPoint: Double? {
        guard let humidity, let currentTemp else { return nil }
        let a = 17.27
        let b = 237.7
        let alpha = ((a * currentTemp) / (b + currentTemp)) + log(Double(humidity) / 100.0)
        let dewPoint = (b * alpha) / (a - alpha)
        
        return dewPoint
    }
    
    var body: some View {
        
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "humidity")
                        Text("title_humidity")
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                if let humidity = humidity, let dewPoint = dewPoint {
                    Text("%\(String(humidity))")
                        .font(.system(size: 35))
                    
                    Spacer()
                    
                    Text(String(format: NSLocalizedString("humidity_description", comment: ""), dewPoint))
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                    
                } else {
                    ColorManager.placeholderRectangle(width: 100, height: 20)
                    Spacer()
                    ColorManager.placeholderRectangle(width: 60, height: 20)
                }
                
            }
            .padding()
            .foregroundStyle(.white)
        }
        .background {
            ColorManager.backgroundColor()
        }
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        VStack {
            HumidityView(humidity: 12, currentTemp: 12.0)
            HumidityView(humidity: nil, currentTemp: nil)
        }
    }
}
