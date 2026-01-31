//
//  VisibilityView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 21.12.2025.
//

import SwiftUI

struct VisibilityView: View {
    let visibility: Int?
    
    var visibilityInKm: Double? {
        guard let visibility = visibility else { return nil }
        return Double(visibility) / 1000.0
    }
    
    private var descriptionText: String? {
        guard let km = visibilityInKm else { return nil }
        
        switch km {
        case 10...:
            return "visibility_perfect".localized
        case 5..<10:
            return "visibility_good".localized
        case 2..<5:
            return "visibility_haze".localized
        case ..<2:
            return "visibility_fog".localized
        default:
            return "visibility_varies".localized
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "eye.fill")
                    Text("title_visibility")
                }
                .font(.system(size: 13))
                .foregroundStyle(.white)
                .opacity(0.5)
                Divider()
                    .background(Color.white)
                    .opacity(0.5)
            }
            
            Spacer()
            
            if let visibilityInKm = visibilityInKm, let descriptionText = descriptionText {
                
                Text("\(visibilityInKm.formatted(.number.precision(.fractionLength(0...1)))) km")
                    .font(.system(size: 35))
                
                Spacer()
                
                Text(descriptionText)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                
            } else {
                ColorManager.placeholderRectangle(width: 100, height: 20)
                Spacer()
                ColorManager.placeholderRectangle(width: 60, height: 20)
            }
            
        }
        .padding()
        .foregroundStyle(.white)
        .background {
            ColorManager.backgroundColor()
        }
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        HStack {
            VisibilityView(visibility: 12000)
                .frame(width: 180, height: 180)
            
            VisibilityView(visibility: 4500)
                .frame(width: 180, height: 180)
        }
    }
}
