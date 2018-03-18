//
//  Place.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation

struct Place {
    var country: String = ""
    var city: String = ""
    var street: String = ""
    var houseNumber: String = ""
    
    var topDescription: String {
        return String("\(city), \(country.uppercased())")
    }
    var lowDescription: String {
        return String("\(street) \(houseNumber)")
    }
}


extension Place {
    
    static func ==(lhs: Place, rhs: Place) -> Bool  {
        let equal = lhs.country == rhs.country &&
            lhs.city == rhs.city &&
            lhs.street == rhs.street &&
            lhs.houseNumber == rhs.houseNumber
        return equal
    }
    
    static func !=(lhs: Place, rhs: Place) -> Bool  {
        return !(lhs == rhs)
    }
    
}
