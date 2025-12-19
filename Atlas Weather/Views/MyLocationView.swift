//
//  MyLocationView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct MyLocationView: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                DetailsView(navigationPath: $navigationPath, topPadding: 50, latitude: 41.0082, longitude: 28.9784, showFavoriteButton: false)
            }
        }
    }
}

#Preview {
    MyLocationView()
}

