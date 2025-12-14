//
//  SearchView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var navigationPath = NavigationPath()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                
            }
            .navigationTitle(Text("Search"))
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    SearchView()
}
