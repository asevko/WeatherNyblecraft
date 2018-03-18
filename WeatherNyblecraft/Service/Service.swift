//
//  Service.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation

class Service {
    
    static var settingsManager: SettingsService {
        return SettingsService.shared
    }
    
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
