//
//  Atlas_WeatherApp.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 9.12.2025.
//

import SwiftUI
import FChucker

@main
struct Atlas_WeatherApp: App {
    
    @StateObject var userLocationManager = UserLocationManager.shared
    
    //    init() {
    //        // Start network monitoring
    //#if DEBUG
    //        FChucker.start()
    //#endif
    //    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userLocationManager)
            //                .networkToasts()
        }
    }
}
