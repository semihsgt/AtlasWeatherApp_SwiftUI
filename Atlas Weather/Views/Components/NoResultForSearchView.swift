//
//  NoResultForSearchView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 19.12.2025.
//

import SwiftUI

struct NoResultForSearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text("No Results")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("No result for '\(searchText)'")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
