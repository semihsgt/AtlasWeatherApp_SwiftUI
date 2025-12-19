//
//  HourlyView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import SwiftUI

struct HourlyView: View {
    var weather: HourlyForecastModel?
    
    private var validHours: [(dt: Int, icon: String, temp: Double)]? {
        guard let list = weather?.list, !list.isEmpty else { return nil }
        
        let filteredData = list.compactMap { item -> (Int, String, Double)? in
            guard let dt = item.dt,
                  let icon = item.weather?.first?.icon,
                  let temp = item.main?.temp else {
                return nil
            }
            return (dt, icon, temp)
        }
        
        return filteredData.isEmpty ? nil : filteredData
    }
    
    var body: some View {
        if let hours = validHours {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(hours, id: \.dt) { hour in
                        VStack(spacing: 8) {
                            VStack(spacing: 0) {
                                
                                if let timezone = weather?.city?.timezone {
                                    Text(hour.dt.toFormattedDate("HH", offset: timezone))
                                        .font(.system(size: 15))
                                    + Text(hour.dt.toFormattedDate("a", offset: timezone))
                                        .font(.system(size: 12))
                                } else {
                                    Text("-")
                                        .font(.system(size: 17))
                                }
                            }
                            
                            Image(systemName: WeatherIconMapper.toSFSymbol(hour.icon))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .padding(.vertical, 10)
                            
                            Text("\(Int(hour.temp.rounded()))°")
                                .font(.system(size: 17))
                        }
                        .frame(minWidth: 50)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16, style: .circular)
                        .foregroundStyle(ColorManager.backgroundColor)
                }
            }
            
        } else {
            placeholderView
        }
    }
    
    private var placeholderView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(0..<6, id: \.self) { _ in
                    VStack(spacing: 8) {
                        Capsule().fill(.gray.opacity(0.1)).frame(width: 40, height: 15)
                        Circle().fill(.gray.opacity(0.1)).frame(width: 30, height: 30)
                        Capsule().fill(.gray.opacity(0.1)).frame(width: 30, height: 20)
                    }
                    .frame(width: 50, height: 100)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .foregroundStyle(ColorManager.backgroundColor)
            }
        }
        .disabled(true)
    }
}

#Preview {
    HourlyView(weather: HourlyForecastModel.mockData())
    HourlyView(weather: nil)
}
