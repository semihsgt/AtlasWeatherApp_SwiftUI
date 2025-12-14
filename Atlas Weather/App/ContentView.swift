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
    }
}

private enum TabKey {
    case location, favorites, search
}

#Preview {
    ContentView()
}
