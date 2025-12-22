//
//  MapView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 22.12.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    let lat: Double?
    let lon: Double?
    let locationDot: Bool
    @State private var region: MKCoordinateRegion
    
    init(lat: Double?, lon: Double?, locationDot: Bool) {
        self.lat = lat
        self.lon = lon
        self.locationDot = locationDot
        
        let center = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lon ?? 0)
        self._region = State(initialValue: MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        ))
    }
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 15))
                        Text("MAP")
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    Divider()
                        .background(Color.white)
                        .opacity(0.5)
                }
                
                Spacer()
                
                Map(coordinateRegion: $region, showsUserLocation: locationDot ? true : false)
                    .allowsHitTesting(false)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 5)
                
                
            }
            .padding()
        }
        .frame(minHeight: 400)
        .background {
            ColorManager.backgroundColor
        }
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        VStack {
            MapView(lat: 37.331516, lon: -121.891054, locationDot: true)
            MapView(lat: nil, lon: nil, locationDot: false)
        }
    }
}
