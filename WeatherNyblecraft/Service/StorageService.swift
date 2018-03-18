//
//  StorageService.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


class StorageService {
    
    private static var instance: StorageService! = nil
    
    static var shared: StorageService {
        if instance == nil {
            instance = StorageService()
        }
        return instance
    }
    
    private var path = "users"
    
    private var ref: DatabaseReference?
}

extension StorageService {
    
    func registerUser() {
        ref = Database.database().reference()
        let username = Service.settingsManager.value(for: KeyPath.user.rawValue) as! String
        ref?.child(path).observe(.value, with: { (snap) in
            if !snap.hasChild(username) {
                self.ref?.child(self.path).child(username).setValue(username)
            }
        })
    
    }
    
    func save(data weather: WeatherData) {
        ref = Database.database().reference()
        
    }
    
}
