//
//  LocationManager.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 20.12.2025.
//

internal import CoreLocation
internal import Combine

final class UserLocationManager: NSObject, ObservableObject {
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    static let shared = UserLocationManager()
    private let manager = CLLocationManager()
    
    @Published var userlocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
}

extension UserLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        
        switch status {
        case .notDetermined:
            debugPrint("DEBUG: Not Determined")
        case .restricted:
            debugPrint("DEBUG: Restricted")
        case .denied:
            debugPrint("DEBUG: Denied")
        case .authorizedAlways:
            debugPrint("DEBUG: Auth always")
        case .authorizedWhenInUse:
            debugPrint("DEBUG: Auth when in use")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userlocation = location
    }
}
