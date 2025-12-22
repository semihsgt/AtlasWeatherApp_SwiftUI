//
//  ErrorView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct ErrorView: View {
    let description: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            Text("Something went wrong")
                .font(.headline)
            Text(description)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ErrorView(description: "The internet connection appears to be offline.")
}
