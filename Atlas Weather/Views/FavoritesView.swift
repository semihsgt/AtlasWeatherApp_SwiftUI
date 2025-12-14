//
//  FavoritesView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct FavoritesView: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                
            }
            .navigationTitle(Text("Favorites"))
        }
    }
}

#Preview {
    FavoritesView()
}
