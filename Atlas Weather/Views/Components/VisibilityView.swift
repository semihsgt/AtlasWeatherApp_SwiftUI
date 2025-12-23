//
//  VisibilityView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct VisibilityView: View {
    let visibility: Int?
    
    var body: some View {
        
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "eye.fill")
                            .font(.system(size: 15))
                        Text("VISIBILITY")
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                if let visibility = visibility {
                    if visibility/1000 == 10 {
                        Text("Max")
                            .font(.system(size: 35))
                    } else {
                        Text("\(String(visibility/1000)) km")
                            .font(.system(size: 35))
                    }
                } else {
                    ColorManager.placeholderRectangle(width: 100, height: 20)
                }
                
            }
            .padding()
            .foregroundStyle(.white)
        }
        .background {
            ColorManager.backgroundColor()
        }
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        VStack {
            VisibilityView(visibility: 12)
            VisibilityView(visibility: nil)
        }
    }
}
