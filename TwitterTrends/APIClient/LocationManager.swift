//
//  LocationManager.swift
//  TwitterTrends
//
//  Created by Daniel Henshaw on 20/9/18.
//  Copyright © 2018 Dan Henshaw. All rights reserved.
//

protocol ReturnLocationDelegate : class {
    func updateLocationData(currentLatitude: Double, currentLongitude: Double)
}

import CoreLocation

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager = CLLocationManager()
    weak var delegate : ReturnLocationDelegate?
    
    func getLocation() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        print("Error \(error)")
    }
    
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied, .notDetermined : print("Error with location authorisation: \(status)")
        default : manager.startUpdatingLocation()
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        
        let currentLocation : CLLocation = locations[0] as CLLocation
        let currentLatitude : Double = currentLocation.coordinate.latitude
        let currentLongitude : Double = currentLocation.coordinate.longitude
        
        self.delegate?.updateLocationData(currentLatitude: currentLatitude, currentLongitude: currentLongitude)

    }
    
}
