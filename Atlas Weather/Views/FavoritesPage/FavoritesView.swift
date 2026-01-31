//
//  FavoritesView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct FavoritesView: View {
    
    @State private var navigationPath = NavigationPath()
    @ObservedObject private var viewModel = FavoritesViewModel.shared
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if viewModel.favoritesWeatherData.isEmpty {
                    Text("title_noFavorites")
                        .padding(.horizontal, 15)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                } else {
                    ScrollView {
                        ForEach(viewModel.favoritesWeatherData) { city in
                            if #available(iOS 18.0, *) {
                                NavigationLink {
                                    DetailsView(path: $navigationPath, lat: city.coord?.lat, lon: city.coord?.lon)
                                        .navigationTransition(.zoom(sourceID: city.id, in: namespace))
                                } label: {
                                    CardView(weather: city)
                                }
                                .matchedTransitionSource(id: city.id, in: namespace)
                            } else {
                                NavigationLink {
                                    DetailsView(path: $navigationPath, lat: city.coord?.lat, lon: city.coord?.lon)
                                } label: {
                                    CardView(weather: city)
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
            .navigationTitle("title_favorites")
        }
    }
}

#Preview {
    FavoritesView()
}
