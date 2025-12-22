//
//  ColorManager.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation
import SwiftUI

struct ColorManager {
    
    static var backgroundColor: some View {
        return Color.black.opacity(0.1)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    static func placeholderCapsule(width: CGFloat? = 100, height: CGFloat? = 100) -> some View {
        Capsule()
            .fill(Color.black.opacity(0.1))
            .frame(width: width, height: height)
    }
    
    static func placeholderRectangle(width: CGFloat? = 100, height: CGFloat? = 100) -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.black.opacity(0.1))
            .frame(width: width, height: height)
    }
}
