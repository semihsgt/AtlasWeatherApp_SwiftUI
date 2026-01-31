//
//  HeroWeather.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 18.12.2025.
//

import SwiftUI

struct HeroWeather: View {
    let current: CurrentWeatherModel?
    var isLocPage: Bool
    
    var body: some View {
        if let current = current,
           let name = current.name,
           let main = current.main,
           let temp = main.temp,
           let tempMax = main.tempMax,
           let tempMin = main.tempMin,
           let weatherArray = current.weather,
           let firstWeather = weatherArray.first,
           let description = firstWeather.description {
            
            VStack {
                
                if(isLocPage) {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("title_heroLocation")
                            
                    }
                    .foregroundStyle(.secondary)
                }
                
                Text(name)
                    .font(.system(size: 37, weight: .regular))
                
                Text("\(Int(temp.rounded()))")
                    .font(.system(size: 102, weight: .thin))
                    .overlay(alignment: .topTrailing) {
                        Text("°")
                            .font(.system(size: 102, weight: .thin))
                            .offset(x: 30)
                    }
                
                Text(description.capitalized)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.secondary)
                
                Text("\("tempMax".localized):\(Int(tempMax.rounded()))°  \("tempMin".localized):\(Int(tempMin.rounded()))°")
                    .font(.system(size: 21, weight: .medium))
            }
            .foregroundStyle(.white)
        } else {
            placeholderView
        }
    }
    
    private var placeholderView: some View {
        VStack(spacing: 10) {
            ColorManager.placeholderCapsule(width: 200, height: 48)
            ColorManager.placeholderRectangle(width: 160, height: 108)
            ColorManager.placeholderCapsule(width: 120, height: 33)
            ColorManager.placeholderCapsule(width: 140, height: 33)
        }
        .padding()
    }
}

#Preview {
    VStack {
        HeroWeather(current: CurrentWeatherModel.MockData(), isLocPage: true)
        HeroWeather(current: nil, isLocPage: true)
    }
    .background {
        SkyGradients.dayGradient
    }
    
}
