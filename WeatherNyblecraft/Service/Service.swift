//
//  Service.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation

/*
    This class is made to hide from view controllers and ect.
    that they are working with singletones.
    It's something like Service Manager pattern
 */
class Service {
    
    static var locationManager: LocationService {
        return LocationService.shared
    }
    
    static var weatherManager: WeatherService {
        return WeatherService.shared
    }
    
    static var storageManager: StorageService {
        return StorageService.shared
    }
    
}
