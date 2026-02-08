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
    
    let lat: Double?
    let lon: Double?
    let isMyLocPage: Bool
    
    @Binding var path: NavigationPath
    @StateObject private var viewModel: DetailsViewModel
    @EnvironmentObject var userLocationManager: UserLocationManager
    @State private var isSheetOn = false
    @State private var isSettingsSheetOn = false
    @State private var opacity = 0.0
    @AppStorage("selected_unit") private var selectedUnit: Unit = .metric
    
    var body: some View {
        NavigationStack(path: $path) {
            switch viewModel.status {
            case .idle:
                EmptyView()
                
            case .loading:
                Color.clear
                
            case .success:
                let (current, hourly, daily) = (viewModel.current, viewModel.hourly, viewModel.daily)
                
                let period = DayPeriod.determine(sunrise: current?.sys?.sunrise, sunset: current?.sys?.sunset, currentTime: current?.dt)
                
                ScrollView {
                    if userLocationManager.authorizationStatus == .denied && isMyLocPage == true {
                        DeniedPermissionView()
                    } else if isMyLocPage == true {
                        HeroWeather(current: current, isLocPage: true)
                            .padding(.top, 30)
                            .padding(.bottom, 50)
                    } else {
                        HeroWeather(current: current, isLocPage: false)
                            .padding(.bottom, 50)
                    }
                    
                    
                    VStack {
                        
                        if let country = viewModel.country,
                           let countryUnsplash = viewModel.countryUnsplash {
                            Button {
                                isSheetOn = true
                            } label: {
                                ExploreCardView(country: country)
                                    .sheet(isPresented: $isSheetOn) {
                                        ExploreView(country: country, countryUnsplash: countryUnsplash)
                                    }
                            }
                        }
                        
                        HourlyView(weather: hourly, current: current)
                            .aspectRatio(2.1, contentMode: .fill)
                        
                        DailyView(weather: daily, current: current)
                            .aspectRatio(2.1, contentMode: .fill)
                        
                        HStack {
                            SunTrackView(sunrise: current?.sys?.sunrise, sunset: current?.sys?.sunset, timezone: current?.timezone, dt: current?.dt)
                            FeelsLikeView(feelsLike: current?.main?.feelsLike, temp: current?.main?.temp)
                        }
                        .aspectRatio(2.0, contentMode: .fill)
                        
                        HStack {
                            HumidityView(humidity: current?.main?.humidity, currentTemp: current?.main?.temp)
                            VisibilityView(visibility: current?.visibility)
                        }
                        .aspectRatio(2.0, contentMode: .fill)
                        
                        HStack {
                            RainfallView(rainfall: current?.rain?.last1H, rainfallTomorrow: daily?.list?[1].rain)
                            PressureView(pressure: current?.main?.pressure)
                        }
                        .aspectRatio(2.0, contentMode: .fill)
                        
                        HStack {
                            SnowfallView(snowfall: current?.snow?.last1H, snowfallTomorrow: daily?.list?[1].snow)
                            WindView(speed: current?.wind?.speed, deg: current?.wind?.deg, gust: current?.wind?.gust)
                        }
                        .aspectRatio(2.0, contentMode: .fill)
                        
                        MapView(lat: current?.coord?.lat, lon: current?.coord?.lon, locationDot: isMyLocPage ? true : false)
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .scrollIndicators(.hidden)
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
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.37)) {
                        opacity = 1.0
                    }
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
    DetailsView(lat: 37.7749, lon: -122.194, isMyLocPage: true)
        .environmentObject(UserLocationManager.shared)
    //    DetailsView(lat: nil, lon: nil)
}

