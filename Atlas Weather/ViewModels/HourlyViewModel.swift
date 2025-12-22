//
//  HourlyViewModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import Foundation

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
