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
                .foregroundStyle(.white)
                .opacity(0.5)
                
                Divider()
                    .background(Color.white)
                    .opacity(0.5)
                
                ForEach(Array(days.enumerated()), id: \.element.id) { idx, day in
                    HStack {
                        if let dt = day.dt, let timezone = weather.city?.timezone {
                            Text(idx == 0 ? "Today" : String((dt.toFormattedDate("EEEE", offset: timezone)).prefix(3)))
                                .frame(width: 50, alignment: .leading)
                                .font(.system(size: 15))
                                .foregroundStyle(.white)
                        } else {
                            Image(systemName: "minus")
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(width: 50, alignment: .leading)
                                .font(.system(size: 15))
                        }
                        
                        if let icon = day.weather?.first?.icon {
                            Image(systemName: WeatherIconMapper.toSFSymbol(icon))
                                .frame(width: 30)
                                .symbolRenderingMode(.multicolor)
                                .foregroundStyle(.white)
                        } else {
                            Image(systemName: "minus")
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(width: 30)
                        }
                        
                        if let tempMin = day.temp?.min {
                            Text("\(Int(tempMin.rounded()))°")
                                .frame(width: 40)
                                .foregroundColor(.white.opacity(0.5))
                                .font(.system(size: 15, weight: .medium))
                        } else {
                            Text("-")
                                .frame(width: 40)
                                .foregroundColor(.white.opacity(0.5))
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
                                .foregroundStyle(.white)
                                .frame(width: 40, alignment: .trailing)
                                .font(.system(size: 15))
                        } else {
                            Text("-")
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(width: 40, alignment: .trailing)
                                .font(.system(size: 15))
                        }
                        
                    }
                    .padding(.vertical, 8)
                    
                    if idx != days.count - 1 {
                        Divider()
                            .background(Color.white)
                            .opacity(0.5)
                    }
                }
            }
            .padding()
            .background {
                ColorManager.backgroundColor
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
            .foregroundStyle(.white)
            .opacity(0.5)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            VStack(alignment: .center) {
                ForEach(0..<2, id: \.self) { _ in
                    HStack {
                        ColorManager.placeholderCapsule(width: 50, height: 15)
                        ColorManager.placeholderCapsule(width: 25, height: 25)
                        ColorManager.placeholderCapsule(width: 30, height: 15)
                        ColorManager.placeholderCapsule(width: 155, height: 6)
                        ColorManager.placeholderCapsule(width: 30, height: 15)
                    }
                    .padding(.vertical, 8)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
            }
        }
        .padding()
        .background {
            ColorManager.backgroundColor
        }
    }
}

#Preview {
    VStack {
        DailyView(weather: DailyForecastModel.MockData(),current: CurrentWeatherModel.MockData())
        DailyView(weather: nil, current: nil)
    }
    .frame(height: 950)
    .background {
        SkyGradients.dayGradient
    }
}
