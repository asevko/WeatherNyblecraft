//
//  WeatherViewModel.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation

enum RequestValidationState {
    case Valid
    case Invalid(String)
}

class WeatherViewModel {
    
    private var weatherData: WeatherData!
    
    var place: Place {
        return weatherData.place
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var icon: String {
        var icon = weatherData.icon
        if icon == "wind" {
            addPostfix(to: &icon)
        }
        return icon
    }
    
    var temperature: Double {
        return weatherData.temperature
    }
    
    // first is lat second is long
    var coordinates: (Double, Double) {
        let lat = weatherData.lat
        let long = weatherData.long
        return (lat, long)
    }
    
    var windSpeed: Double {
        return weatherData.windSpeed
    }
    
    var time: String {
        return String.string(from: weatherData.time)
    }

}


extension WeatherViewModel {
    
    func requestWeatehr(completion: @escaping(_ type: RequestValidationState) -> Void) {
        Service.weatherManager.getWeather { (weather, error) in
            if weather != nil {
                self.weatherData = weather
                completion(.Valid)
                return
            }
            completion(.Invalid(error ?? "Sorry, something went wrong"))
        }
    }
    
}


extension WeatherViewModel {
    
    func addPostfix(to: inout String)  {
        let currentTime = Calendar.current.component(.hour, from: weatherData.time)
        to += currentTime < 19 && currentTime > 7 ? "-day" : "-night"
        print(to)
    }
    
}

