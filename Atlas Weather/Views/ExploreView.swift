//
//  ExploreView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 23.12.2025.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    
    init(country: CountryModel) {
        self.country = country
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: country.capitalLocation.latitude, longitude: country.capitalLocation.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1),
        )
    }
    
    let country: CountryModel
    @State private var region: MKCoordinateRegion
    @State private var opacity = 0.0
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
                        
                        Text("\(country.name.capitalized) \(country.flag)")
                            .font(.largeTitle)
                            .padding(.vertical, 25)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        
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
            .navigationTitle("\(country.name)")
            .toolbar(.hidden, for: .navigationBar)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.37)) {
                opacity = 1.0
            }
        }
    }
}

#Preview {
    ExploreView(country: CountryModel.mockData())
}
