//
//  Configuration.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let Latitude: Double = 53.9
    static let Longitude: Double =  27.56667
    
}

struct API {
    //remove secret key later
    static let APIKey = "f9fe9dc21091815de1590da09e75e0e3"
    static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }
}
