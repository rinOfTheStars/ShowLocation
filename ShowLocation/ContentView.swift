//
//  ContentView.swift
//  ShowLocation
//
//  Created by ***REMOVED*** on 4/24/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    var internalLocManager = CLLocationManager()
    func initLocManager() {
        internalLocManager.desiredAccuracy = kCLLocationAccuracyBest
        internalLocManager.desiredAccuracy = kCLLocationAccuracyBest
        internalLocManager.requestWhenInUseAuthorization()
    }
    
    func makeUIView(context: Context) -> some UIView {
        initLocManager()
        let mapView = MKMapView(frame: UIScreen.current!.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct ContentView: View {
    @ObservedObject private var locHandler = LocationHandler()
    
    var body: some View {
        let lat: String! = LocationHandler.resolveLatitude(locationHandler: locHandler)
        let long: String! = LocationHandler.resolveLongitude(locationHandler: locHandler)
        VStack {
            Text("Show My Location")
                .font(.largeTitle)
                .fontWeight(.bold)
            MapView()
            
            Text("Your Coordinates:")
                .font(.title)
                .padding(.top, 10)
            HStack {
                Text("Latitude:")
                    .fontWeight(.bold)
                Text(lat)
            }
            HStack {
                Text("Longitude:")
                    .fontWeight(.bold)
                Text(long)
            }
        }
        .padding()
    }
}

//Both extensions taken from https://stackoverflow.com/a/76728094
extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else {
                continue
            }
            for window in windowScene.windows {
                return window
            }
        }
        return nil
    }
}

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

#Preview {
    ContentView()
}
