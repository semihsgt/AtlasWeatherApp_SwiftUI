//
//  ErrorView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct ErrorView: View {
    let description: String
    var languageManager = LanguageManager.shared
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            Text("title_error")
                .font(.headline)
            
            if (languageManager.currentLanguage == "tr") {
                Text("error_description")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            } else {
                Text(description)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ErrorView(description: "The internet connection appears to be offline.")
}
