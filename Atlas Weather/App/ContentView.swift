//
//  ContentView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: TabKey = .location
    
    var body: some View {
        if #available(iOS 18.0, *) {
            TabView(selection: $selection) {
                Tab("My Location", systemImage: "location", value: TabKey.location) {
                    MyLocationView()
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
                MyLocationView()
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

private enum TabKey: Hashable {
    case location, favorites, search
}

#Preview {
    ContentView()
}
