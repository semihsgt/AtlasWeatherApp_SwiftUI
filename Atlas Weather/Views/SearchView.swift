//
//  SearchView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var navigationPath = NavigationPath()
    @StateObject private var viewModel = SearchViewModel()
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                switch viewModel.searchStatus {
                case .idle:
                    
                    ScrollView {
                        ForEach(viewModel.cities) { city in
                            if #available(iOS 18.0, *) {
                                NavigationLink {
                                    DetailsView(navigationPath: $navigationPath, lat: city.coord?.lat, lon: city.coord?.lon)
                                        .navigationTransition(.zoom(sourceID: city.id, in: namespace))
                                } label: {
                                    CardView(weather: city)
                                }
                                .matchedTransitionSource(id: city.id, in: namespace)
                            } else {
                                NavigationLink {
                                    DetailsView(navigationPath: $navigationPath, lat: city.coord?.lat, lon: city.coord?.lon)
                                } label: {
                                    CardView(weather: city)
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                    
                case .loading:
                    ProgressView()
                case .success:
                    let results = viewModel.searchData
                    
                    if results.isEmpty {
                        NoResultForSearchView(searchText: $viewModel.searchText)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List(results) { result in
                            if #available (iOS 18.0, *) {
                                NavigationLink {
                                    DetailsView(navigationPath: $navigationPath, lat: result.lat ?? 0, lon: result.lon ?? 0)
                                        .navigationTransition(.zoom(sourceID: result.id , in: namespace))
                                } label: {
                                    Text("\(result.name ?? ""), \(result.country ?? "") \(result.state ?? "")")
                                }
                                .matchedTransitionSource(id: result.id, in: namespace)
                            } else {
                                NavigationLink {
                                    DetailsView(navigationPath: $navigationPath, lat: result.lat ?? 0, lon: result.lon ?? 0)
                                } label: {
                                    Text("\(result.name ?? ""), \(result.country ?? "") \(result.state ?? "")")
                                }
                            }
                        }
                    }
                case .error(let error):
                    ErrorView(description: error.localizedDescription)
                }
            }
            .navigationTitle(Text("Search"))
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a city or airport")
        .onChange(of: viewModel.searchText) { _ in
            viewModel.searchCity()
        }
        .task {
            if viewModel.cities.isEmpty {
                await viewModel.getAllCitiesWeather()
            }
        }
    }
}

#Preview {
    SearchView()
}
