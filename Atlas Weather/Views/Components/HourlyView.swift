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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let timezone = weather?.city?.timezone {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    HStack {
                        Image(systemName: "clock")
                            .font(.system(size: 15))
                        Text("HOURLY FORECAST")
                            .font(.system(size: 15))
                    }
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
                                        Text(dt.toFormattedDate("HH", offset: timezone))
                                            .font(.system(size: 15))
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
                                        Text(time.toFormattedDate(offset: timezone))
                                            .font(.system(size: 15))
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
                                        Text(time.toFormattedDate(offset: timezone))
                                            .font(.system(size: 15))
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
                        Image(systemName: "thermometer.medium")
                            .font(.system(size: 15))
                        Text("FEELS LIKE")
                            .font(.system(size: 15))
                    }
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



