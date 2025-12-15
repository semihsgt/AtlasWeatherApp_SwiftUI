//
//  DailyView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 15.12.2025.
//

import SwiftUI

struct DailyView: View {
    var weather: DailyForecastModel
    var current: CurrentWeatherModel
    
    var globalMin: Double {
        weather.list.compactMap { $0.temp.min }.min() ?? 0
    }
    
    var globalMax: Double {
        weather.list.compactMap { $0.temp.max }.max() ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 15))
                Text("10-DAY FORECAST")
                    .font(.system(size: 15))
            }
            .foregroundStyle(.secondary)
            Divider()
            ForEach(Array(weather.list.enumerated()), id: \.element.dt) { idx, day in
                HStack {
                    
                    Text(idx == 0 ?
                         "Today" :
                            String(day.dt.toFormattedDate("EEEE").prefix(3)))
                    .frame(width: 50, alignment: .leading)
                    
                    Image(systemName: WeatherIconMapper.toSFSymbol(day.weather.first?.icon ?? "10d"))
                        .frame(width: 30)
                    
                    Text("\(Int(day.temp.min))°")
                        .frame(width: 40)
                        .foregroundColor(.secondary)
                    
                    TemperatureBar(
                        dayMin: day.temp.min,
                        dayMax: day.temp.max,
                        globalMin: globalMin,
                        globalMax: globalMax,
                        currentTemp: idx == 0 ? current.main.temp : nil
                    )
                    
                    Text("\(Int(day.temp.max))°")
                }
                if idx != 9 {
                    Divider()
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

#Preview {
    DailyView(weather: DailyForecastModel.MockData(), current: CurrentWeatherModel.MockData())
}
