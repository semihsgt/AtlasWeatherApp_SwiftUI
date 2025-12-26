//
//  ContentView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI
internal import CoreLocation

struct ContentView: View {
    @State private var selection: TabKey = .location
    @State private var isSplashFinished = false
    @EnvironmentObject var userLocationManager: UserLocationManager
    
    var body: some View {
        ZStack {
            Group {
                if userLocationManager.authorizationStatus == .notDetermined {
                    LocationRequestView()
                } else if userLocationManager.authorizationStatus == .authorizedWhenInUse && userLocationManager.userlocation == nil {
                    Color.clear
                } else {
                    AppTabView(selection: $selection)
                }
                
                if !isSplashFinished {
                    SplashView()
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isSplashFinished = true
                }
            }
        }
    }
}

struct AppTabView: View {
    @EnvironmentObject var userLocationManager: UserLocationManager
    @Binding fileprivate var selection: TabKey
    
    var body: some View {
        if #available(iOS 18.0, *) {
            TabView(selection: $selection) {
                Tab("My Location", systemImage: "location", value: TabKey.location) {
                    MyLocationView(
                        lat: (userLocationManager.authorizationStatus == .denied) ? nil : userLocationManager.userlocation?.coordinate.latitude,
                        lon: (userLocationManager.authorizationStatus == .denied) ? nil : userLocationManager.userlocation?.coordinate.longitude
                    )
                }
                Tab("Favorites", systemImage: "star", value: TabKey.favorites) {
                    FavoritesView()
                }
                Tab(value: TabKey.search, role: .search) {
                    SearchView()
                }
            }
        } else {
            TabView(selection: $selection) {
                MyLocationView(
                    lat: (userLocationManager.authorizationStatus == .denied) ? nil : userLocationManager.userlocation?.coordinate.latitude,
                    lon: (userLocationManager.authorizationStatus == .denied) ? nil : userLocationManager.userlocation?.coordinate.longitude
                )
                .tabItem {
                    Label("My Location", systemImage: "location")
                }
                .tag(TabKey.location)
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(TabKey.favorites)
                
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(TabKey.search)
            }
        }
    }
}

fileprivate enum TabKey: Hashable {
    case location, favorites, search
}

#Preview {
    ContentView()
}
