//
//  LanguageManager.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 22.01.2026.
//

import Foundation
internal import Combine

class LanguageManager: ObservableObject {
    
    private init() {
        self.currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        debugPrint(self.currentLanguage)
    }
    
    @Published var currentLanguage: String
    static let shared = LanguageManager()
}
