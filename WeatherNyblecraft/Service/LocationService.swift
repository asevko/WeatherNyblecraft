//
//  LocationManager.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation!

    private var status = CLAuthorizationStatus.notDetermined
    private let inUse = CLAuthorizationStatus.authorizedWhenInUse
    private let always = CLAuthorizationStatus.authorizedAlways
    private static var instance: LocationService! = nil
    
    static var shared: LocationService {
        if instance == nil {
            instance = LocationService()
        }
        return instance
    }

    var latitude: Double {
        if currentLocation != nil {
            return currentLocation.coordinate.latitude
        }
        return Defaults.Latitude
    }
    
    var longitude: Double {
        if currentLocation != nil {
            return currentLocation.coordinate.longitude
        }
        return Defaults.Longitude
    }
    
    var coordinates: (Double, Double) {
        setLocationManager()
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        return (latitude, longitude)
    }
    
    private override init() {
        super.init()
        setLocationManager()
    }

}

extension LocationService: CLLocationManagerDelegate {
    func setLocationManager() {
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
            locationManager.startUpdatingLocation()
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        guard let location = locations.first, location.coordinate.latitude != 0 && location.coordinate.longitude != 0 else {
            return
        }
        
        currentLocation = location
        locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
}


extension LocationService {
    
    func getPlace(completion: @escaping (_ address: Place?, _ error: Error?) -> ()) {
        if self.status == inUse || self.status == always {
            self.currentLocation = locationManager.location
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(self.currentLocation) { placemarks, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    let firstLocation = placemarks?[0]
                    let country = firstLocation?.country ?? ""
                    let city = firstLocation?.locality  ?? ""
                    let street = firstLocation?.thoroughfare ?? ""
                    let houseNumebr = firstLocation?.subThoroughfare ?? ""
                    completion(Place(country: country, city: city, street: street, houseNumber: houseNumebr), nil)
                }
            }
        }
    }
}

