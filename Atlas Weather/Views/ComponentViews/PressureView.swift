//
//  PressureView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 22.12.2025.
//

import SwiftUI

struct PressureView: View {
    let pressure: Int?

    private var progress: Double {
        guard let pressure = pressure else { return 0 }
        let min: Double = 950
        let max: Double = 1050
        return (Double(pressure) - min) / (max - min)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "gauge.with.needle")
                    Text("title_pressure")
                }
                .font(.system(size: 13))
                .foregroundStyle(.white)
                .opacity(0.5)
                Divider()
                    .background(Color.white)
                    .opacity(0.5)
            }
            
            Spacer()
            
            if let pressure = pressure {
                ZStack {
                    Circle()
                        .trim(from: 0.15, to: 0.85)
                        .stroke(Color.white.opacity(0.1), style: StrokeStyle(lineWidth: 12, lineCap: .butt, dash: [2, 4]))
                        .rotationEffect(.degrees(90))
                    
                    Circle()
                        .trim(from: 0.15, to: 0.15 + (progress * 0.7))
                        .stroke(
                            AngularGradient(colors: [.white.opacity(0.5), .white], center: .center, startAngle: .degrees(180), endAngle: .degrees(360)),
                            style: StrokeStyle(lineWidth: 12, lineCap: .butt, dash: [2, 4])
                        )
                        .rotationEffect(.degrees(90))
                    
                    VStack(spacing: -5) {
                        Image(systemName: "equal")
                            .font(.title3)
                            .padding(.bottom, 10)
                        
                        Text("\(pressure)")
                            .font(.system(size: 32))
                        
                        Text("hPa")
                            .font(.title3)
                            .opacity(0.8)
                    }
                }
                .offset(y: 15)
                .padding(.horizontal, 10)
                                
            } else {
                VStack(alignment: .leading) {
                    Spacer()
                    ColorManager.placeholderRectangle(width: 140, height: 40)
                    Spacer()
                    ColorManager.placeholderRectangle(width: 70, height: 30)
                    Spacer()
                }
            }
            
            Spacer()
            
        }
        .padding()
        .foregroundStyle(.white)
        .background(ColorManager.backgroundColor())
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        HStack {
            PressureView(pressure: 1045)
            PressureView(pressure: nil)
        }
    }
}
