//
//  MyLocationView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct MyLocationView: View {
    
    let lat: Double?
    let lon: Double?
    @State var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            DetailsView(navigationPath: $navigationPath, lat: lat, lon: lon, isMyLocPage: true)
        }
    }
}

#Preview {
    MyLocationView(lat: nil, lon: nil)
}

