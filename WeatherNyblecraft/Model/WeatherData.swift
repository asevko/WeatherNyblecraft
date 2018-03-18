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

