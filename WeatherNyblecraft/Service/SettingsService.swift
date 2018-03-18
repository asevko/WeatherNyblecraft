//
//  SettingsService.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation

class SettingsService {
    
    private static var instance: SettingsService! = nil
    
    static var shared: SettingsService {
        if instance == nil {
            instance = SettingsService()
        }
        return instance
    }
    
    private let userDefaults: UserDefaults
    
    private init() {
        userDefaults = UserDefaults()
    }
    
    public func save(value: Any, for key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func value(for key: String) -> Any?{
        return userDefaults.value(forKey: key)
    }
    
    public func remove(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
