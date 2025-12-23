//
//  FeelsLikeView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct FeelsLikeView: View {
    let feelsLike: Double?
    let temp: Double?
    
    private var percentage: Double {
        guard let feelsLike = feelsLike,
              let temp = temp,
              temp != 0 else { return 100 }
        return (feelsLike / temp) * 100
    }
    
    
    var body: some View {
        
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "thermometer.medium")
                            .font(.system(size: 15))
                        Text("FEELS LIKE")
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                if let _ = feelsLike, let _ = temp {
                    
                    Text("%\(String(Int(percentage)))")
                        .font(.system(size: 35))
                } else {
                    ColorManager.placeholderRectangle(width: 100, height: 20)
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
            FeelsLikeView(feelsLike: -1.5, temp: 1)
            FeelsLikeView(feelsLike: 5, temp: nil)
        }
    }
}
