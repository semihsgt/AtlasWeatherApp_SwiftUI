//
//  DeniedPermissionView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 20.12.2025.
//

import SwiftUI

struct DeniedPermissionView: View {
    
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "location.slash.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.red)
            
            Text("Location Permit Required")
                .font(.title2).bold()
            
            Text("In order to automatically see the weather of your location, you need to give location permission from Settings.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 30)
            
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            } label: {
                Text("Go to Settings")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorManager.backgroundColor)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
        .padding(.top, 50)
        .padding(.bottom, 90)
    }
}

#Preview {
    DeniedPermissionView()
}
