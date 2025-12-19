//
//  DailyView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 15.12.2025.
//

import SwiftUI

struct DailyView: View {
    var weather: DailyForecastModel?
    var current: CurrentWeatherModel?
    
    var body: some View {
        
        if let weather = weather,
           let current = current,
           let days = weather.list,
           !days.isEmpty {
            
            let globalMin = days.compactMap { $0.temp?.min }.min() ?? 0
            let globalMax = days.compactMap { $0.temp?.max }.max() ?? 0
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 15))
                    Text("10-DAY FORECAST")
                        .font(.system(size: 15))
                }
                .foregroundStyle(.secondary)
                .padding(.bottom, 5)
                
                Divider()
                
                ForEach(Array(days.enumerated()), id: \.element.dt) { idx, day in
                    HStack {
                        if let dt = day.dt, let timezone = weather.city?.timezone {
                            Text(idx == 0 ? "Today" : String((dt.toFormattedDate("EEEE", offset: timezone)).prefix(3)))
                                .frame(width: 50, alignment: .leading)
                                .font(.system(size: 15))
                        } else {
                            Image(systemName: "minus")
                                .frame(width: 50, alignment: .leading)
                                .font(.system(size: 15))
                        }
                        
                        if let icon = day.weather?.first?.icon {
                            Image(systemName: WeatherIconMapper.toSFSymbol(icon))
                                .frame(width: 30)
                        } else {
                            Image(systemName: "minus")
                                .frame(width: 30)
                        }
                        
                        if let tempMin = day.temp?.min {
                            Text("\(Int(tempMin.rounded()))°")
                                .frame(width: 40)
                                .foregroundColor(.secondary)
                                .font(.system(size: 15, weight: .medium))
                        } else {
                            Text("-")
                                .frame(width: 40)
                                .foregroundColor(.secondary)
                                .font(.system(size: 15, weight: .medium))
                        }
                        
                        TemperatureBar(
                            dayMin: day.temp?.min,
                            dayMax: day.temp?.max,
                            globalMin: globalMin,
                            globalMax: globalMax,
                            currentTemp: idx == 0 ? current.main?.temp : nil
                        )
                        
                        if let tempMin = day.temp?.max {
                            Text("\(Int(tempMin.rounded()))°")
                                .frame(width: 40, alignment: .trailing)
                                .font(.system(size: 15))
                        } else {
                            Text("-")
                                .frame(width: 40, alignment: .trailing)
                                .font(.system(size: 15))
                        }
                        
                    }
                    .padding(.vertical, 8)
                    
                    if idx != days.count - 1 {
                        Divider()
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .foregroundStyle(ColorManager.backgroundColor)
            }
            
        } else {
            placeholderView
        }
    }
    
    private var placeholderView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 15))
                Text("10-DAY FORECAST")
                    .font(.system(size: 15))
            }
            .foregroundStyle(.secondary)
            .opacity(0.5)
            
            Divider()
            
            ForEach(0..<1, id: \.self) { _ in
                HStack {
                    Capsule().fill(.black.opacity(0.1)).frame(width: 50, height: 15)
                    Circle().fill(.black.opacity(0.1)).frame(width: 25, height: 25)
                    Capsule().fill(.black.opacity(0.1)).frame(width: 30, height: 15)
                    Capsule().fill(.black.opacity(0.1)).frame(height: 6).frame(maxWidth: .infinity)
                    Capsule().fill(.black.opacity(0.1)).frame(width: 30, height: 15)
                }
                .padding(.vertical, 8)
                Divider().opacity(0.5)
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
    DailyView(
        weather: DailyForecastModel.MockData(),
        current: CurrentWeatherModel.MockData()
    )
    
    DailyView(weather: nil, current: nil)
}
