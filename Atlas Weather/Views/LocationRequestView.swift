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
            Spacer()
            
            Image(systemName: "location.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(SkyGradients.dayGradient)
                .frame(width: 200, height: 200)
                .padding()
            
            VStack(spacing: 5) {
                Text("title_requestLocation")
                    .font(.system(size: 28, weight: .semibold))
                
                Text("requestLocation_description")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 50)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Button {
                userLocationManager.requestLocation()
            } label: {
                Text("button_allowLocation")
                    .padding()
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, -32)
                    .background(SkyGradients.dayGradient)
                    .clipShape(Capsule())
                
            }
            .padding(.vertical)
            
            Spacer()
        }
    }
}

#Preview {
    LocationRequestView()
}
