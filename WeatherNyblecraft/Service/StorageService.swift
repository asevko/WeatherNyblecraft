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
    
    var requestsRef: DatabaseReference {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        return (ref?.child("users/\(userID!)/requests"))!
    }
    
    private var ref: DatabaseReference?
}

extension StorageService {
    
    func save(data weather: WeatherData) {
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        let key = self.ref?.child("users/\(userID!)/requests").childByAutoId().key
        let childUpdates = ["users/\(userID!)/requests/\(key!)": weather.toDatabaseFormat()]
        self.ref?.updateChildValues(childUpdates)
    }
    
}


