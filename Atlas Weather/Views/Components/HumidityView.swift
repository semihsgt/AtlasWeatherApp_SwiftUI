//
//  HumidityView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct HumidityView: View {
    let humidity: Int?
    
    var body: some View {
        
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "humidity")
                            .font(.system(size: 15))
                        Text("HUMIDITY")
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                if let humidity = humidity {
                    Text("%\(String(humidity))")
                        .font(.system(size: 35))
                } else {
                    ColorManager.placeholderRectangle(width: 100, height: 20)
                }
                
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
        VStack {
            HumidityView(humidity: 12)
            HumidityView(humidity: nil)
        }
    }
}
