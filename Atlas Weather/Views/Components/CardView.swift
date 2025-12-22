//
//  CardView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct CardView: View {
    let weather: CurrentWeatherModel?
    
    var body: some View {
        
        if let weather = weather,
           let name = weather.name,
           let dt = weather.dt,
           let sys = weather.sys,
           let sunrise = sys.sunrise,
           let sunset = sys.sunset,
           let main = weather.main,
           let temp = main.temp,
           let timezone = weather.timezone,
           let description = weather.weather?.first?.description,
           let tempMax = main.tempMax,
           let tempMin = main.tempMin {
            
            mainCardView(
                name: name,
                dt: dt,
                sunrise: sunrise,
                sunset: sunset,
                temp: temp,
                tempMax: tempMax,
                tempMin: tempMin,
                timezone: timezone,
                description: description,
            )
            
        } else {
            fallbackView
        }
    }
    
    private func mainCardView(name: String, dt: Int, sunrise: Int, sunset: Int, temp: Double, tempMax: Double, tempMin: Double, timezone: Int, description: String) -> some View {
        
        let skyGradient: LinearGradient = {
            switch DayPeriod.determine(sunrise: sunrise, sunset: sunset, currentTime: dt) {
            case .night: return SkyGradients.nightGradient
            case .sunrise: return SkyGradients.sunriseGradient
            case .day: return SkyGradients.dayGradient
            case .sunset: return SkyGradients.sunsetGradient
            }
        }()
        
        return VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 25, weight: .bold))
                    
                    Text(dt.toFormattedDate(offset: timezone))
                        .font(.system(size: 15, weight: .medium))
                }
                Spacer()
                Text("\(Int(temp))°")
                    .font(.system(size: 53, weight: .light))
            }
            Spacer()
            HStack {
                Text(description.capitalized)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Text("H:\(Int(tempMax.rounded()))°  L:\(Int(tempMin.rounded()))°")
                    .font(.system(size: 15, weight: .medium))
            }
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 90)
        .foregroundStyle(.white)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .foregroundStyle(skyGradient)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
    
    
    private var fallbackView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    ColorManager.placeholderRectangle(width: 100, height: 25)
                    ColorManager.placeholderRectangle(width: 60, height: 15)
                }
                Spacer()
                ColorManager.placeholderRectangle(width: 60, height: 50)
            }
            Spacer()
            ColorManager.placeholderRectangle(width: .infinity, height: 20)
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 90)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(16)
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    CardView(weather: CurrentWeatherModel.MockData())
    CardView(weather: nil)
}
