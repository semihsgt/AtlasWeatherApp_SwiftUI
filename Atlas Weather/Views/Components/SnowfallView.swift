//
//  SnowfallView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct SnowfallView: View {
    let snowfall: Double?
    let snowfallTomorrow: Double?
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "snowflake")
                            .font(.system(size: 15))
                        Text("SNOWFALL")
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                
                Spacer()
                
                Text("\(String(Int(snowfall ?? 0))) mm")
                    .font(.system(size: 35))
                
                Text("in last 1h")
                    .font(.system(size: 25))
                
                Spacer()
                
                Text("\(String(Int(snowfallTomorrow ?? 0))) mm expected tomorrow.")
                    .font(.system(size: 17))
                
                
                
            }
            .padding()
            .foregroundStyle(.white)
        }
        .background {
            ColorManager.backgroundColor
        }
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        HStack {
            SnowfallView(snowfall: 12, snowfallTomorrow: 32)
            SnowfallView(snowfall: nil, snowfallTomorrow: nil)
        }
        .frame(height: 160)
    }
}
