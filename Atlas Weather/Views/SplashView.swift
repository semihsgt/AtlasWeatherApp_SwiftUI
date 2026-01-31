//
//  SplashView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 24.12.2025.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Image("Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .shadow(radius: 10)
                
                Text("title_splash")
                    .frame(width: 250, height: 150)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(5)
                    .shadow(radius: 10)
            }
        }
    }
}

#Preview {
    SplashView()
}
