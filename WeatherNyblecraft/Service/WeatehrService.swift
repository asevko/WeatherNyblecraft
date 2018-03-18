//
//  WeatehrService.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation
import SwiftSky

class WeatherService {
    
    private static var instance: WeatherService! = nil

    static var shared: WeatherService {
        if instance == nil {
            instance = WeatherService()
        }
        return instance
    }
    
    var weather: WeatherData!
    
    private init() {
        configure()
    }


}

extension WeatherService {
    private func configure() {
        SwiftSky.secret = "f9fe9dc21091815de1590da09e75e0e3"
        
        SwiftSky.units.temperature = .celsius
        SwiftSky.units.speed = .meterPerSecond
    }
}

extension WeatherService {
    
    func getWeather(completion: @escaping(_ weather: WeatherData?, _ error: String?) -> Void) {
        let locationManager = Service.locationManager
        var longitude = locationManager.longitude
        var latitude = locationManager.latitude
        SwiftSky.get([.current], at: Location(latitude: latitude, longitude: longitude)){
            (result) in
             switch result {
                case .success(let forecast):
                    Service.locationManager.getPlace { (place, error) in
                        guard place != nil else {
                            completion(nil, error?.localizedDescription ?? "Unknown error")
                            return
                        }
                        let summary = forecast.current?.summary ?? ""
                        let icon = forecast.current?.icon ?? ""
                        let time = forecast.current?.time ?? Date()
                        let windSpeed = forecast.current?.wind?.speed?.value ?? 0
                        let temperature =  forecast.current?.temperature?.current?.value ?? 0
                        longitude = locationManager.longitude
                        latitude = locationManager.latitude
                        self.weather = WeatherData(summary: summary, icon: icon, time: time, lat: latitude, long: longitude, windSpeed: windSpeed, temperature: temperature, place: place!)
                        completion(self.weather, nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
            }
        }
    }
    
}
