//
//  WindView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct WindView: View {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "wind")
                        Text("title_wind")
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    HStack {
                        Text("wind_speed")
                        Spacer()
                        if let speed = speed {
                            Text("\(String(format: "%.1f", speed)) m/s")
                        } else {
                            Text("--")
                        }
                    }
                    
                    Divider()
                        .background(Color.white)
                        .opacity(0.25)
                    
                    HStack {
                        Text("wind_direction")
                        Spacer()
                        if let deg = deg {
                            HStack(spacing: 4) {
                                Image(systemName: "location.north.fill")
                                    .rotationEffect(.degrees(Double(deg)))
                                    .font(.system(size: 12))
                                Text(" \(deg)°")
                            }
                        } else {
                            Text("--")
                        }
                    }
                    
                    Divider()
                        .background(Color.white)
                        .opacity(0.25)
                    
                    HStack {
                        Text("wind_gust")
                        Spacer()
                        if let gust = gust {
                            Text("\(String(format: "%.1f", gust)) m/s")
                        } else {
                            Text("--")
                        }
                    }
                    
                }
                
                Spacer()
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
        HStack {
            WindView(speed: 0.86, deg: 323, gust: 1.53)
            WindView(speed: nil, deg: nil, gust: nil)
        }
        .frame(height: 200)
    }
}
