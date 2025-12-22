//
//  LocationManager.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 20.12.2025.
//

internal import CoreLocation
internal import Combine

class UserLocationManager: NSObject, ObservableObject {
    
    private let manager = CLLocationManager()
    @Published var userlocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    static let shared = UserLocationManager()
        
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
}


extension UserLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        self.authorizationStatus = status
        switch status {
        case .notDetermined:
            print("DEBUG: Not Determined")
        case .restricted:
            print("DEBUG: Restricted")
        case .denied:
            print("DEBUG: Denied")
        case .authorizedAlways:
            print("DEBUG: Auth always")
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userlocation = location
    }
    
    
}
