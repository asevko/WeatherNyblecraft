//
//  StringExtension.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation

extension String {
    
    public static func string(from time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "HH:mm MMM d"
        return dateFormatter.string(from: time)
    }
    
    public func validate() -> String {
        guard let pos = self.range(of: String("@")) else { return self }
        let subString = self[..<pos.lowerBound]
        return String(subString)
    }
    
}
