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
                        Text("title_rainfall")
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                if (Locale.current.language.languageCode?.identifier == "tr") {
                    Text("rainfall_lastHour")
                        .font(.system(size: 15))
                    Text("\(String(Int(rainfall ?? 0))) mm")
                        .font(.system(size: 35))
                } else {
                    Text("\(String(Int(rainfall ?? 0))) mm")
                        .font(.system(size: 35))
                    
                    Text("rainfall_lastHour")
                        .font(.system(size: 25))
                }
                
                Spacer()
                
                Text("rainfall_description".localized(with: Int(rainfallTomorrow ?? 0)))
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
