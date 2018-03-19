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

    private var weathers: [WeatherData] = []
    
}

// MARK: - getters
extension WeatherViewModel {
    
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
    
    var getHistory: [WeatherData] {
        return weathers
    }
    
    func getWeather(at index: Int) -> WeatherData {
        return weathers[index]
    }
    
}


extension WeatherViewModel {
    
    func requestWeatehr(completion: @escaping(_ type: RequestValidationState) -> Void) {
        Service.weatherManager.getWeather { (weather, error) in
            if weather != nil {
                self.weatherData = weather
                Service.storageManager.save(data: weather!)
                completion(.Valid)
                return
            }
            completion(.Invalid(error ?? "Sorry, something went wrong"))
        }
    }
    
}

// MARK: - implementing database events
extension WeatherViewModel {
    
    func subscribeOnFirstLoad(_ completion: @escaping()-> Void) {
        Service.storageManager.requestsRef.observeSingleEvent(of: .value, with: { (snap) in
            let dataDictionary = snap.value as! [String: Any]
            dataDictionary.forEach { (key, body) in
                let body = body as! [String: Any]
               
                let weather = self.dictionaryToWeather(dict: body)
                
                self.weathers.append(weather)
                completion()
            }
        })
    }
    
    func subscribeOnDelete(_ completion: @escaping()-> Void) {
        Service.storageManager.requestsRef.observe(.childRemoved) { (snap) in
            let body = snap.value as! [String: Any]
            
            let weather = self.dictionaryToWeather(dict: body)
        
            self.weathers = self.weathers.filter() {
                $0 != weather
            }
            
            completion()
        }
    }
    
    func subscribeOnAdding(_ completion: @escaping()-> Void) {
        Service.storageManager.requestsRef.observe(.childAdded) { (snap) in
            let body = snap.value as! [String: Any]
            
            let weather = self.dictionaryToWeather(dict: body)
            
            self.weathers.append(weather)
            completion()
        }
    }
}

// MARK: - private functions
extension WeatherViewModel {
    
    private func addPostfix(to: inout String)  {
        let currentTime = Calendar.current.component(.hour, from: weatherData.time)
        to += currentTime < 19 && currentTime > 7 ? "-day" : "-night"
        print(to)
    }

    private func dictionaryToWeather(dict body: [String: Any]) -> WeatherData {
        let summary = body["summary"] as! String
        let temperature = body["temperature"] as! Double
        let windSpeed = body["windSpeed"] as! Double
        let icon = body["icon"] as! String
        let interval = body["time"] as! Double
        let time = Date(timeIntervalSince1970: interval)
        let lattitude = body["lattitude"] as! Double
        let longtitude = body["longtitude"] as! Double
        
        let country = body["country"] as! String
        let city = body["city"] as! String
        let street = body["street"] as! String
        let houseNumber = body["houseNumber"] as! String
        
        let place = Place(country: country, city: city, street: street, houseNumber: houseNumber)
        let weather = WeatherData(summary: summary, icon: icon, time: time, lat: lattitude, long: longtitude, windSpeed: windSpeed, temperature: temperature, place: place)
        
        return weather
    }
    
}






