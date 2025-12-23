//
//  DetailsView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI
internal import CoreLocation

struct DetailsView: View {
    
    init(path: Binding<NavigationPath> = .constant(NavigationPath()), lat: Double?, lon: Double?, isMyLocPage: Bool = false) {
        self._path = path
        self.lat = lat
        self.lon = lon
        _viewModel = StateObject(wrappedValue: DetailsViewModel(lat: lat, lon: lon))
        self.isMyLocPage = isMyLocPage
    }
    
    @Binding var path: NavigationPath
    @StateObject private var viewModel: DetailsViewModel
    let lat: Double?
    let lon: Double?
    let isMyLocPage: Bool
    @ObservedObject var userLocationManager = UserLocationManager.shared
    @State private var isSheetShown = false
    
    
    var body: some View {
        NavigationStack(path: $path) {
            switch viewModel.status {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success:
                
                let (current, hourly, daily) = (viewModel.current, viewModel.hourly, viewModel.daily)
                
                let period = DayPeriod.determine(sunrise: current?.sys?.sunrise, sunset: current?.sys?.sunset, currentTime: current?.dt)
                
                ScrollView {
                    if userLocationManager.authorizationStatus == .denied && isMyLocPage == true {
                        DeniedPermissionView()
                    } else if isMyLocPage == true {
                        HeroWeather(current: current)
                            .padding(.top, 50)
                            .padding(.bottom, 50)
                    } else {
                        HeroWeather(current: current)
                            .padding(.bottom, 50)
                    }
                    
                    
                    VStack {
                        
                        if let country = viewModel.country {
                            Button {
                                isSheetShown = true
                            } label: {
                                ExploreCardView(country: country)
                                    .sheet(isPresented: $isSheetShown) {
                                        ExploreView(country: country)
                                    }
                            }
                        }
                        
                        HourlyView(weather: hourly, current: current)
                        
                        DailyView(weather: daily, current: current)
                        
                        HStack{
                            SunTrackView(sunrise: current?.sys?.sunrise, sunset: current?.sys?.sunset, timezone: current?.timezone, dt: current?.dt)
                            
                            FeelsLikeView(feelsLike: current?.main?.feelsLike, temp: current?.main?.temp)
                        }
                        
                        HStack {
                            HumidityView(humidity: current?.main?.humidity)
                            VisibilityView(visibility: current?.visibility)
                        }
                        
                        HStack {
                            RainfallView(rainfall: current?.rain?.last1H, rainfallTomorrow: daily?.list?[1].rain)
                            PressureView(pressure: current?.main?.pressure)
                        }
                        
                        HStack {
                            SnowfallView(snowfall: current?.snow?.last1H, snowfallTomorrow: daily?.list?[1].snow)
                            WindView(speed: current?.wind?.speed, deg: current?.wind?.deg, gust: current?.wind?.gust)
                        }
                        
                        MapView(lat: current?.coord?.lat, lon: current?.coord?.lon, locationDot: isMyLocPage ? true : false)
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .toolbar {
                    if !isMyLocPage {
                        Button {
                            let locationToSave = SavedFavorite(id: current?.id ?? 0)
                            viewModel.toggleFavorite(location: locationToSave)
                        } label: {
                            Image(systemName: viewModel.isFavorite(id: current?.id ?? 0) ? "star.fill" : "star")
                        }
                    }
                }
                .background {
                    viewModel.getSkyGradient(for: period)
                        .frame(width: UIScreen.main.bounds.width)
                        .ignoresSafeArea(edges: .all)
                }
                
            case .error(let error):
                ErrorView(description: error.localizedDescription)
            }
        }
        .task {
            await viewModel.getAllWeathers()
        }
        .onChange(of: userLocationManager.authorizationStatus) { newStatus in
            if isMyLocPage {
                if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                    Task {
                        if let loc = userLocationManager.userlocation {
                            viewModel.updateLocation(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
                        }
                        await viewModel.getAllWeathers()
                    }
                } else if newStatus == .denied || newStatus == .restricted {
                    Task {
                        viewModel.updateLocation(lat: nil, lon: nil)
                        await viewModel.getAllWeathers()
                    }
                }
            }
        }
    }
}

#Preview {
    DetailsView(lat: 37.7749, lon: -122.194)
    //    DetailsView(lat: nil, lon: nil)
}

