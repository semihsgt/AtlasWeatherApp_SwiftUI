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
    
    private var descriptionText: String? {
        guard let feelsLike = feelsLike?.rounded(),
              let temp = temp?.rounded() else {return nil}
        
        let diffVal = Int((abs(feelsLike - temp)).rounded())
        
        if diffVal == 0 {
            return NSLocalizedString("feels_like_similar", comment: "")
        } else if feelsLike > temp {
            return String(format: NSLocalizedString("feels_like_warmer", comment: ""), diffVal)
        } else {
            return String(format: NSLocalizedString("feels_like_colder", comment: ""), diffVal)
        }
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "thermometer.medium")
                    Text("title_feelsLike")
                }
                .font(.system(size: 13))
                .foregroundStyle(.white)
                .opacity(0.5)
                Divider()
                    .background(Color.white)
                    .opacity(0.5)
            }
            
            Spacer()
            
            if let feelsLike = feelsLike, let _ = temp, let descriptionText = descriptionText {
                
                Text("\(Int(feelsLike.rounded()))°")
                    .font(.system(size: 35))
                
                Spacer()
                
                Text(descriptionText)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                
            } else {
                ColorManager.placeholderRectangle(width: 50, height: 20)
                Spacer()
                ColorManager.placeholderRectangle(width: 100, height: 20)
            }
            
        }
        .padding()
        .foregroundStyle(.white)
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
            FeelsLikeView(feelsLike: 20, temp: 20)
                .frame(width: 180, height: 200)
            
            FeelsLikeView(feelsLike: -6, temp: 0)
                .frame(width: 180, height: 200)
        }
    }
}
