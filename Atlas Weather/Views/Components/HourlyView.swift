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
                ForEach(weather.list ?? [], id: \.dt) { item in
                    VStack {
                        Text(item.dt?.toFormattedDate() ?? "")
                            .font(.system(size: 17, weight: .medium))
                        
                        Image(systemName: WeatherIconMapper.toSFSymbol(item.weather?.first?.icon ?? "10d"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                        
                        Text("\(Int(item.main?.temp?.rounded() ?? 0))°")
                            .font(.system(size: 22, weight: .medium))
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

extension Int {
    func toFormattedDate(_ format: String = "HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

#Preview {
    HourlyView(weather: HourlyForecastModel.mockData())
}
