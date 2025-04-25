//
//  LocationHandler.swift
//  ShowLocation
//
//  Created by ***REMOVED*** on 4/24/25.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.location = location
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: any Error) {
        return
    }
    
    private static func resolveLocation(locationHandler : LocationHandler) -> CLLocationCoordinate2D! {
        guard let loc = locationHandler.location else {
            let locDefault = CLLocation(latitude: 0, longitude: 0)
            return locDefault.coordinate
        }
        return loc.coordinate
    }
    
    static func resolveLatitude(locationHandler: LocationHandler) -> String! {
        guard let coord = resolveLocation(locationHandler: locationHandler) else {
            let coord = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
            return coord.latitude.description
        }
        return coord.latitude.description
    }
    
    static func resolveLongitude(locationHandler: LocationHandler) -> String! {
        guard let coord = resolveLocation(locationHandler: locationHandler) else {
            let coord = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
            return coord.longitude.description
        }
        return coord.longitude.description
    }
}
