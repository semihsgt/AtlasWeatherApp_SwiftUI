//
//  DetailsView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct DetailsView: View {
    
    init(navigationPath: Binding<NavigationPath> = .constant(NavigationPath())) {
        self._navigationPath = navigationPath
    }
    
    @Binding var navigationPath: NavigationPath
    @State private var viewModel = DetailsViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            switch viewModel.status {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success(let weather):
                
                let current = weather.current
                let hourly = weather.hourly
                let daily = weather.daily
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack {
                            Text(current.name)
                                .font(.system(size: 37, weight: .regular))
                            Text("\(Int(weather.current.main.temp.rounded()))")
                                .font(.system(size: 102, weight: .thin))
                                .overlay(alignment: .topTrailing) {
                                    Text("°")
                                        .font(.system(size: 102, weight: .thin))
                                        .alignmentGuide(.trailing) { d in d[.leading] }
                                }
                            Text("\(current.weather.first?.description.capitalized ?? "")")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundStyle(.secondary)
                            Text("H:\(Int(current.main.tempMax))° L:\(Int(current.main.tempMin))°")
                                .font(.system(size: 21, weight: .medium))
                        }
                        .padding(.bottom, 50)
                        
                        
                        HourlyView(weather: hourly)
                            .cornerRadius(15)
                            .padding(.horizontal)
                        
                        DailyView(weather: daily, current: CurrentWeatherModel.MockData())
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
                
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .task {
            await viewModel.getAllDetails()
        }
    }
}

#Preview {
    DetailsView()
}



