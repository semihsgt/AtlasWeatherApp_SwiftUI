//
//  HourlyView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import SwiftUI

struct HourlyView: View {
    let weather: HourlyForecastModel?
    let current: CurrentWeatherModel?
    @AppStorage("selected_timeFormat") private var selectedtimeFormat: TimeFormat = .twentyFourHour
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let timezone = weather?.city?.timezone {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    HStack {
                        Image(systemName: "clock")
                        Text("title_hourlyForecast")
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 5) {
                        if let current = current, let temp = current.main?.temp {
                            VStack(spacing: 4) {
                                
                                Text("Now")
                                    .font(.system(size: 15))
                                
                                Image(systemName: WeatherIconMapper.toSFSymbol(current.weather?.first?.icon))
                                    .symbolRenderingMode(.multicolor)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 15)
                                
                                Text("\(Int(temp.rounded()))°")
                                    .font(.system(size: 15))
                            }
                            .frame(minWidth: 50)
                            
                        } else {
                            VStack(spacing: 8) {
                                ColorManager.placeholderCapsule(width: 40, height: 15)
                                ColorManager.placeholderCapsule(width: 30, height: 30)
                                ColorManager.placeholderCapsule(width: 30, height: 15)
                            }
                            .frame(width: 49, height: 100)
                        }
                        
                        ForEach(combinedTimeline) { item in
                            VStack(spacing: 4) {
                                
                                
                                switch item {
                                case .weather(let hour):
                                    
                                    if let dt = hour.dt {
                                        if (selectedtimeFormat.rawValue == "12h") {
                                            Text(dt.toFormattedDate("h", offset: timezone))
                                                .font(.system(size: 15))
                                        } else {
                                            Text(dt.toFormattedDate("H", offset: timezone))
                                                .font(.system(size: 15))
                                        }
                                    } else {
                                        ColorManager.placeholderCapsule(width: 40, height: 15)
                                    }
                                    
                                    if let icon = hour.weather?.first?.icon {
                                        Image(systemName: WeatherIconMapper.toSFSymbol(icon))
                                            .symbolRenderingMode(.multicolor)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .padding(.vertical, 15)
                                    } else {
                                        ColorManager.placeholderCapsule(width: 30, height: 30)
                                            .padding(.vertical, 15)
                                    }
                                    
                                    if let temp = hour.main?.temp {
                                        Text("\(Int(temp.rounded()))°")
                                            .font(.system(size: 15))
                                    } else {
                                        ColorManager.placeholderCapsule(width: 30, height: 15)
                                    }
                                    
                                    
                                    
                                case .sunrise(let time):
                                    
                                    VStack(spacing: 4) {
                                        if (selectedtimeFormat.rawValue == "12h") {
                                            Text(time.toFormattedDate("h:mm", offset: timezone))
                                                .font(.system(size: 15))
                                        } else {
                                            Text(time.toFormattedDate("H:mm", offset: timezone))
                                                .font(.system(size: 15))
                                        }
                                        Image(systemName: "sunrise.fill")
                                            .symbolRenderingMode(.multicolor)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .padding(.vertical, 15)
                                        Text("Sunrise")
                                            .font(.system(size: 15))
                                    }
                                    .padding(.horizontal)
                                    
                                case .sunset(let time):
                                    
                                    VStack(spacing: 4) {
                                        if (selectedtimeFormat.rawValue == "12h") {
                                            Text(time.toFormattedDate("h:mm", offset: timezone))
                                                .font(.system(size: 15))
                                        } else {
                                            Text(time.toFormattedDate("H:mm", offset: timezone))
                                                .font(.system(size: 15))
                                        }
                                        
                                        Image(systemName: "sunset.fill")
                                            .symbolRenderingMode(.multicolor)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .padding(.vertical, 15)
                                        Text("Sunset")
                                            .font(.system(size: 15))
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .frame(minWidth: 50)
                        }
                    }
                }
                .padding(.top)
                
            } else {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    HStack {
                        Image(systemName: "clock")
                        Text("title_hourlyForecast")
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                placeholderView
                    .padding(.top)
            }
        }
        .padding()
        .background {
            ColorManager.backgroundColor()
        }
        .foregroundStyle(.white)
    }
    
    private var placeholderView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(0..<23, id: \.self) { _ in
                    VStack(spacing: 8) {
                        ColorManager.placeholderCapsule(width: 40, height: 15)
                        ColorManager.placeholderCapsule(width: 30, height: 30)
                        ColorManager.placeholderCapsule(width: 30, height: 15)
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        VStack {
            HourlyView(weather: HourlyForecastModel.mockData(), current: CurrentWeatherModel.MockData())
            HourlyView(weather: nil, current: nil)
        }
    }
}

extension HourlyView {
    var combinedTimeline: [TimelineItem] {
        guard let list = weather?.list,
              let firstHour = list.first,
              let startTime = firstHour.dt else {
            return []
        }
        
        var items: [TimelineItem] = []
        
        for hour in list {
            if hour.dt != nil {
                items.append(.weather(hour))
            }
        }
        
        if let sunrise = weather?.city?.sunrise, sunrise > startTime {
            items.append(.sunrise(sunrise))
        }
        
        if let sunset = weather?.city?.sunset, sunset > startTime {
            items.append(.sunset(sunset))
        }
        
        return items.sorted { $0.id < $1.id }
    }
}

enum TimelineItem: Identifiable {
    case weather(HourlyForecastModel.ListHourly)
    case sunrise(Int)
    case sunset(Int)
    
    var id: Int {
        switch self {
        case .weather(let data): return data.dt ?? 0
        case .sunrise(let time): return time
        case .sunset(let time): return time
        }
    }
}

