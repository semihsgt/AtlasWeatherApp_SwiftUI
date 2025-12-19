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
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                switch viewModel.searchStatus {
                case .idle:
                    
                        ScrollView {
                            ForEach(viewModel.cities, id: \.id) { city in
                                NavigationLink {
                                    DetailsView(navigationPath: $navigationPath, topPadding: 0,
                                                latitude: city.coord?.lat ?? 0, longitude: city.coord?.lon ?? 0)
                                } label: {
                                    CardView(weather: city)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
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
                        List(results, id: \.lat) { item in
                            NavigationLink {
                                DetailsView(navigationPath: $navigationPath, topPadding: 0,
                                            latitude: item.lat ?? 0, longitude: item.lon ?? 0)
                            } label: {
                                Text("\(item.name ?? ""), \(item.country ?? "") \(item.state ?? "")")
                            }
                        }
                    }
                case .error(let error):
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text("Something went wrong")
                            .font(.headline)
                        Text(error.localizedDescription)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
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
