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
                NavigationLink("Details View") {
                    DetailsView(navigationPath: $navigationPath)
                }
            }
            .navigationTitle(Text("My Location"))
        }
    }
}

#Preview {
    MyLocationView()
}
