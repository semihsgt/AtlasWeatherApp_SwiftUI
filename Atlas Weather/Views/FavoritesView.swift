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
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if viewModel.favoritesWeatherData.isEmpty {
                    Text("No Favorite Cities Yet")
                        .offset(y: -30)
                } else {
                    ScrollView {
                        ForEach(viewModel.favoritesWeatherData, id: \.id) { city in
                            NavigationLink {
                                DetailsView(navigationPath: $navigationPath, topPadding: 0, latitude: city.coord?.lat, longitude: city.coord?.lon)
                            } label: {
                                CardView(weather: city)
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Favorites"))
        }
    }
}

#Preview {
    FavoritesView()
}
