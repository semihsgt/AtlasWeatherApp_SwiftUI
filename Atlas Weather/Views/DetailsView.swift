//
//  DetailsView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct DetailsView: View {
    
    init(navigationPath: Binding<NavigationPath> = .constant(NavigationPath()), topPadding: CGFloat, latitude: Double?, longitude: Double?, showFavoriteButton: Bool = true) {
        self._navigationPath = navigationPath
        self.topPadding = topPadding
        self.latitude = latitude
        self.longitude = longitude
        _viewModel = StateObject(wrappedValue: DetailsViewModel(latitude: latitude, longitude: longitude))
        self.showFavoriteButton = showFavoriteButton
    }
    
    @Binding var navigationPath: NavigationPath
    @StateObject private var viewModel: DetailsViewModel
    let latitude: Double?
    let longitude: Double?
    let showFavoriteButton: Bool
    var topPadding: CGFloat
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            switch viewModel.status {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success:
                
                let (current, hourly, daily) = (viewModel.current, viewModel.hourly, viewModel.daily)
                
                let period = DayPeriod.determine(sunrise: current?.sys?.sunrise, sunset: current?.sys?.sunset, currentTime: current?.dt)
                
                ScrollView {
                    HeroWeather(current: current)
                        .padding(.top, topPadding)
                        .padding(.bottom, 50)
                    
                    VStack {
                        if let hourly {
                            HourlyView(weather: hourly)
                                .cornerRadius(15)
                                .padding(.horizontal)
                        }
                        
                        if let daily, let current {
                            DailyView(weather: daily, current: current)
                                .cornerRadius(15)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 90)
                }
                .toolbar {
                    showFavoriteButton ? ToolbarItem {
                        Button {
                            let locationToSave = SavedFavorite(id: current?.id ?? 0)
                            viewModel.toggleFavorite(location: locationToSave)
                        } label: {
                            Image(systemName: viewModel.isFavorite(id: current?.id ?? 0) ? "star.fill" : "star")
                        }
                    } : nil
                }
                .background {
                    viewModel.getSkyGradient(for: period)
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .white, location: 0),
                                    Gradient.Stop(color: .clear, location: 1),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                }
                .ignoresSafeArea(edges: .bottom)
                
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .task {
            await viewModel.getAllWeathers()
        }
    }
}

#Preview {
    DetailsView(topPadding: 80, latitude: 37.7749, longitude: -122.4194)
}

