//
//  ExploreViewModel.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 2.02.2026.
//

import Foundation
internal import Combine

@MainActor
class ExploreViewModel: ObservableObject {
    private var networkDataManager = NetworkDataManager.shared
    @Published var urls: [String] = []
    
    func getCountryPhotos(countryName: String?) async {
        guard urls.isEmpty else { return }
        self.urls = await networkDataManager.getCountryPhotos(countryName: countryName)
    }
}
