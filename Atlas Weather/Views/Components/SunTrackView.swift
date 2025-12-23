//
//  SunTrackView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct SunTrackView: View {
    let sunrise: Int?
    let sunset: Int?
    let timezone: Int?
    let dt: Int?
    
    var isNightValue: Bool {
        guard let dt, let sunrise, let sunset else { return false }
        return dt < sunrise || dt > sunset || dt == sunset
    }
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: isNightValue ? "sunrise.fill" : "sunset.fill")
                            .font(.system(size: 15))
                        Text(isNightValue ? "SUNRISE" : "SUNSET")
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                if let sunrise = sunrise,
                   let sunset = sunset,
                   let timezone = timezone {
                    
                    let displayTime = isNightValue ? sunrise : sunset
                    
                    Text(displayTime.toFormattedDate(offset: timezone))
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
            SunTrackView(sunrise: 5, sunset: 10, timezone: 0, dt: 17)
            SunTrackView(sunrise: 5, sunset: nil, timezone: 0, dt: 111)
        }
        .frame(height: 80)
    }
}
