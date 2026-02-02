//
//  ExploreView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 23.12.2025.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    
    init(country: CountryModel, countryUnsplash: CountryUnsplashModel) {
        self.country = country
        self.countryUnsplash = countryUnsplash
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: country.capitalLocation.latitude, longitude: country.capitalLocation.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1),
        )
    }
    
    let countryUnsplash: CountryUnsplashModel
    let country: CountryModel
    @State private var region: MKCoordinateRegion
    @State private var opacity = 0.0
    @StateObject private var viewModel = ExploreViewModel()
    
    private var independent: String {
        if (Locale.current.language.languageCode?.identifier == "tr") {
            if (country.independent) {return "Evet"} else {return "Hayır"}
        } else {
            if (country.independent) {return "Yes"} else {return "No"}
        }
    }
    
    var formattedPopulation: String {
        let num = Double(country.population)
        if num >= 1_000_000_000 { return String(format: "%.1fB", num / 1_000_000_000) }
        if num >= 1_000_000 { return String(format: "%.1fM", num / 1_000_000) }
        if num >= 1_000 { return String(format: "%.1fK", num / 1_000) }
        return "\(country.population)"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                let url = URL(string: country.flagURL)
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .ignoresSafeArea()
                        .blur(radius: 50)
                        .scaleEffect(2.2)
                        .brightness(-0.3)
                } placeholder: {
                    Color.gray
                        .ignoresSafeArea()
                }
                
                
                ScrollView {
                    VStack {
                        
                        if (!viewModel.urls.isEmpty) {
                            TabView {
                                ForEach(viewModel.urls, id: \.self) { urlString in
                                    AsyncImage(url: URL(string: urlString)) { phase in
                                        switch phase {
                                            
                                        case .empty:
                                            
                                            ZStack {
                                                Color.gray.opacity(0.1)
                                                ProgressView()
                                            }
                                            
                                        case .success(let image):
                                            
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .overlay(content: {
                                                    LinearGradient(
                                                        colors: [.black.opacity(0.4), .clear],
                                                        startPoint: .bottom,
                                                        endPoint: .center
                                                    )
                                                })
                                            
                                        case .failure(let error):
                                            
                                            ZStack {
                                                Color.gray.opacity(0.1)
                                                VStack {
                                                    Image(systemName: "exclamationmark.triangle")
                                                        .font(.largeTitle)
                                                        .foregroundColor(.white)
                                                    Text("title_error")
                                                        .font(.headline)
                                                    Text(error.localizedDescription)
                                                        .font(.caption)
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(.secondary)
                                                }
                                            }
                                            
                                        @unknown default:
                                            EmptyView()
                                            
                                        }
                                        
                                    }
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal)
                            .transition(.opacity)
                            
                        } else {
                            ZStack {
                                Color.gray.opacity(0.1)
                                ProgressView()
                            }
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal)
                        }
                        
                        NavigationLink {
                            MapSheetView(lat: country.capitalLocation.latitude, lon: country.capitalLocation.longitude)
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Image(systemName: "map.fill")
                                        Text("title_capitalLocation")
                                        Image(systemName: "chevron.forward")
                                    }
                                    .font(.system(size: 13))
                                    .foregroundStyle(.white)
                                    .opacity(0.5)
                                    
                                    Divider()
                                        .background(Color.white)
                                        .opacity(0.5)
                                }
                                .padding()
                                
                                Map(coordinateRegion: $region)
                                    .allowsHitTesting(false)
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .padding([.horizontal, .bottom])
                            }
                            .background {
                                ColorManager.backgroundColor(opacity: 0.3)
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        VStack(alignment: .center, spacing: 10) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("title_aboutTheCountry")
                                }
                                .font(.system(size: 13))
                                .foregroundStyle(.white)
                                .opacity(0.5)
                                
                                Divider()
                                    .background(Color.white)
                                    .opacity(0.5)
                            }
                            .padding([.horizontal, .top])
                            
                            Text(country.summary)
                                .multilineTextAlignment(.leading)
                                .italic()
                                .padding([.horizontal, .bottom])
                        }
                        .background {
                            ColorManager.backgroundColor(opacity: 0.3)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .center, spacing: 10) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "list.bullet")
                                    Text("title_otherDetails")
                                }
                                .font(.system(size: 13))
                                .foregroundStyle(.white)
                                .opacity(0.5)
                                
                                Divider()
                                    .background(Color.white)
                                    .opacity(0.5)
                            }
                            .padding([.horizontal, .top])
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("• \("otherDetails_region".localized): \(country.subregion)")
                                    Text("• \("otherDetails_capitals".localized): \(country.capital.joined(separator: ", "))")
                                    Text("• \("otherDetails_population".localized): \(formattedPopulation)")
                                    Text("• \("otherDetails_languages".localized): \(country.languages.joined(separator: ", "))")
                                    Text("• \("otherDetails_currency".localized): \(country.currencies.currencyCode) \(country.currencies.symbol) (\(country.currencies.name))")
                                    Text("• \("otherDetails_demonym".localized): \(country.demonym)")
                                    Text("• \("otherDetails_driving_side".localized): \(country.drivingSide.capitalized)")
                                    Text("• \("otherDetails_start_of_week".localized): \(country.startOfWeek.capitalized)")
                                    Text("• \("otherDetails_independent".localized): \(independent.capitalized)")
                                    Text("• \("otherDetails_id".localized): \(country.id)")
                                    Text("• \("otherDetails_timezones".localized): \(country.timezones.joined(separator: ", "))")
                                }
                                .multilineTextAlignment(.leading)
                                .padding([.horizontal, .bottom])
                                Spacer()
                            }
                        }
                        .background {
                            ColorManager.backgroundColor(opacity: 0.3)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                    }
                    .presentationDragIndicator(.visible)
                    .foregroundStyle(.white)
                }
            }
            .navigationTitle("\(country.name.capitalized) \(country.flag)")
        }
        .task{
            await viewModel.getCountryPhotos(countryName: countryUnsplash.name)
        }
        .preferredColorScheme(.dark)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.37)) {
                opacity = 1.0
            }
        }
    }
}

#Preview {
    let data = CountryUnsplashModel(id: "TR", name: "Turkey")
    ExploreView(country: CountryModel.mockData(), countryUnsplash: data)
}
