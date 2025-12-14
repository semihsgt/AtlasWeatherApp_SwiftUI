//
//  LoadingState.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 13.12.2025.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case success(T)
    case error(Error)
}
