//
//  LocationRequestView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 20.12.2025.
//

import SwiftUI

struct LocationRequestView: View {
    @EnvironmentObject var userLocationManager: UserLocationManager
    
    var body: some View {
        VStack {
            
            Image(systemName: "location.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(SkyGradients.dayGradient)
                .frame(width: 200, height: 200)
                .padding()
            
            VStack(spacing: 5) {
                Text("Allow Your Location")
                    .font(.system(size: 28, weight: .semibold))
                
                Text("We need your location to show you the weather of your location.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 50)
                    .padding(.horizontal)
            }
            
            Button {
                userLocationManager.requestLocation()
            } label: {
                Text("Allow Location")
                    .padding()
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, -32)
                    .background(SkyGradients.dayGradient)
                    .clipShape(Capsule())
                
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    LocationRequestView()
}
