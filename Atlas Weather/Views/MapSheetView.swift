//
//  MapSheetView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 25.12.2025.
//

import SwiftUI
import MapKit

struct MapSheetView: View {
    
    init(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
        let center = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lon ?? 0)
        self.region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        )
    }
    
    let lat: Double?
    let lon: Double?
    @State private var opacitiy: Double = 0
    
    @State var region: MKCoordinateRegion
    
    var body: some View {
        
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
            .opacity(opacitiy)
            .onAppear {
                withAnimation(.easeIn(duration: 0.37)) {
                    self.opacitiy = 1.0
                }
            }
    }
}

#Preview {
    MapSheetView(lat: 12, lon: 12)
}

