//
//  WeatherData.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation


struct WeatherData {
    let summary: String
    let icon: String
    let time: Date
    
    let lat: Double
    let long: Double
    let windSpeed: Double
    let temperature: Double
    
    let place: Place
}


extension WeatherData {
    
    func toDatabaseFormat() -> [String: Any] {
        let formattedTime = time.timeIntervalSince1970
        let dataInRightFormat: [String: Any] =
            ["summary": summary,
            "temperature": temperature,
            "windSpeed": windSpeed,
            "icon": icon,
//            "time": String.string(from: time),
            "time": formattedTime,
            "lattitude": lat,
            "longtitude": long,
            "country": place.country,
            "city": place.city,
            "street": place.street,
            "houseNumber": place.houseNumber]
        return dataInRightFormat
    }
    
}

extension WeatherData {
    
    static func ==(lhs: WeatherData, rhs: WeatherData) -> Bool {
        let equal = lhs.summary == rhs.summary &&
            lhs.time == rhs.time &&
            lhs.temperature == rhs.temperature &&
            lhs.icon == rhs.icon &&
            lhs.windSpeed == rhs.windSpeed &&
            lhs.lat == rhs.lat &&
            lhs.long == rhs.long &&
            lhs.place == rhs.place
        return equal
    }
    
    static func !=(lhs: WeatherData, rhs: WeatherData) -> Bool {
        return !(lhs == rhs)
    }
    
}

