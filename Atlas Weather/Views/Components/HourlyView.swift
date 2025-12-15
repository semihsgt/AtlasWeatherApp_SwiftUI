//
//  HourlyView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import SwiftUI

struct HourlyView: View {
    var weather: HourlyForecastModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(weather.list, id: \.dt) { hour in
                    VStack {
                        Text(hour.dt.toFormattedDate("HH"))
                            .font(.system(size: 17))
                        + Text(hour.dt.toFormattedDate("a"))
                            .font(.system(size: 13))
                        
                        
                        Image(systemName: WeatherIconMapper.toSFSymbol(hour.weather.first?.icon ?? "10d"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 45)
                        
                        Text("\(Int(hour.main.temp))°")
                            .font(.system(size: 22))
                            .frame(width: 50)
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .foregroundStyle(ColorManager.backgroundColor)
            }
        }
    }
}

#Preview {
    HourlyView(weather: HourlyForecastModel.mockData())
}
