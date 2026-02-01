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
    @AppStorage("selected_timeFormat") private var selectedTimeFormat: TimeFormat = .twentyFourHour
    
    var isSunriseMode: Bool {
        guard let dt, let sunrise, let sunset else { return false }
        return dt < sunrise || dt >= sunset
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: isSunriseMode ? "sunrise.fill" : "sunset.fill")
                    Text(isSunriseMode ? "title_sunrise" : "title_sunset")
                }
                .font(.system(size: 13))
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
                
                let displayTime = isSunriseMode ? sunrise : sunset
                
                if (selectedTimeFormat.rawValue == "12h") {
                    Text(displayTime.toFormattedDate("h:mm a", offset: timezone))
                        .font(.system(size: 35))
                } else {
                    Text(displayTime.toFormattedDate(offset: timezone))
                        .font(.system(size: 35))
                }
                
                
                Spacer()
                
                if isSunriseMode {
                    if (selectedTimeFormat.rawValue == "12h") {
                        Text("sunset_will_be_at".localized(with: sunset.toFormattedDate("h:mm a", offset: timezone)))
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                    } else {
                        Text("sunset_will_be_at".localized(with: sunset.toFormattedDate(offset: timezone)))
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                    }
                } else {
                    if (selectedTimeFormat.rawValue == "12h") {
                        Text("sunrise_will_be_at".localized(with: sunrise.toFormattedDate("h:mm a", offset: timezone)))
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                    } else {
                        Text("sunrise_will_be_at".localized(with: sunrise.toFormattedDate(offset: timezone)))
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                    }
                    // Since our API plan doesn't provide next-day sunrise/sunset data, I'll display the current day's sunrise as a placeholder for tomorrow's when the current time (dt) exceeds sunset.
                }
                
            } else {
                ColorManager.placeholderRectangle(width: 100, height: 20)
                Spacer()
                ColorManager.placeholderRectangle(width: 60, height: 20)
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
        VStack {
            SunTrackView(sunrise: 5, sunset: 10, timezone: 0, dt: 17)
                .frame(width: 180, height: 180)
            SunTrackView(sunrise: 5, sunset: nil, timezone: 0, dt: 111)
                .frame(width: 180, height: 180)
        }
    }
}
