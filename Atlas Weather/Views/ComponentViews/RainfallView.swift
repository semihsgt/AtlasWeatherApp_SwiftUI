//
//  RainfallView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct RainfallView: View {
    let rainfall: Double?
    let rainfallTomorrow: Double?
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "drop.fill")
                            .font(.system(size: 15))
                        Text("RAINFALL")
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                Text("\(String(Int(rainfall ?? 0))) mm")
                    .font(.system(size: 35))
                
                Text("in last 1h")
                    .font(.system(size: 25))
                
                Spacer()
                
                Text("\(String(Int(rainfallTomorrow ?? 0))) mm expected tomorrow.")
                    .font(.system(size: 14))
                
                
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
            RainfallView(rainfall: 12, rainfallTomorrow: 32)
            RainfallView(rainfall: nil, rainfallTomorrow: nil)
        }
    }
}
