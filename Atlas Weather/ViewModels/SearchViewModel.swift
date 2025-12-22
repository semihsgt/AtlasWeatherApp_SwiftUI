//
//  SearchViewModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 17.12.2025.
//

import Foundation
internal import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published private(set) var searchStatus: LoadingState = .idle
    @Published var cities: [CurrentWeatherModel] = []
    @Published var searchText = ""
    @Published var searchData: [GeocodingModel] = []
    private var searchTask: Task<Void, Never>?
    var networkDataManager = NetworkDataManager.shared
    
    func getAllCitiesWeather() async {
        do {
            let weatherData = try await withThrowingTaskGroup(of: CurrentWeatherModel?.self) { group in
                for city in worldCities {
                    group.addTask {
                        try? await self.networkDataManager.fetchWeather(
                            lat: city.latitude,
                            lon: city.longitude,
                            endpoint: "weather"
                        )
                    }
                }
                var results: [CurrentWeatherModel] = []
                for try await weather in group {
                    if let weather {
                        results.append(weather)
                    }
                }
                return results
            }
            self.cities = weatherData.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
        } catch {
            print(error)
        }
    }
    
    func searchCity() {
        searchTask?.cancel()
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            searchStatus = .idle
            searchData = []
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { 
                searchData = []
                return 
            }
            searchStatus = .loading
            do {
                let result = try await networkDataManager.fetchGeocoding(q: searchText)
                guard !Task.isCancelled else {
                    searchData = []
                    return 
                }
                searchData = result
                searchStatus = .success
            } catch {
                print(error)
                searchStatus = .error(error)
                searchData = []
            }
        }
    }
    
    let worldCities: [(latitude: Double, longitude: Double)] = [
        (41.0082, 28.9784),   // Istanbul, Turkey (UTC+3)
        (51.5074, -0.1278),   // London, UK (UTC+0)
        (48.8566, 2.3522),    // Paris, France (UTC+1)
        (55.7558, 37.6173),   // Moscow, Russia (UTC+3)
        (25.2048, 55.2708),   // Dubai, UAE (UTC+4)
        (28.6139, 77.2090),   // New Delhi, India (UTC+5:30)
        (13.7563, 100.5018),  // Bangkok, Thailand (UTC+7)
        (31.2304, 121.4737),  // Shanghai, China (UTC+8)
        (35.6762, 139.6503),  // Tokyo, Japan (UTC+9)
        (-33.8688, 151.2093), // Sydney, Australia (UTC+10/11)
        (21.3069, -157.8583), // Honolulu, Hawaii (UTC-10)
        (37.7749, -122.4194), // San Francisco, USA (UTC-8)
        (40.7128, -74.0060),  // New York, USA (UTC-5)
        (-22.9068, -43.1729), // Rio de Janeiro, Brazil (UTC-3)
        (64.1466, -21.9426),  // Reykjavik, Iceland (UTC+0)
    ]
    
}


