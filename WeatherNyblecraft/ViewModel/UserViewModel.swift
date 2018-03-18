//
//  UserViewModel.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import Foundation
import FirebaseAuth

enum UserValidationState {
    case Valid
    case Invalid(String)
}

enum RequestType {
    case Login
    case SignUp
}

class UserViewModel {
    
    private let minUsernameLength = 4
    private let minPasswordLength = 3
    private var user = User()
    
    var username: String {
        return user.username
    }
    
    var password: String {
        return user.password
    }
    
    var protectedUsername: String {
        let characters = [Character](username)
        
        if characters.count >= minUsernameLength {
            var displayName = [Character]()
            for (index, character) in characters.enumerated() {
                if index > characters.count - minUsernameLength {
                    displayName.append(character)
                } else {
                    displayName.append("*")
                }
            }
            return String(displayName)
        }
        
        return username
    }
}


extension UserViewModel {
    func updateUsername(username: String) {
        user.username = username
    }
    
    func updatePassword(password: String) {
        user.password = password
    }
    
    func validate() -> UserValidationState {
        if user.username.isEmpty || user.password.isEmpty  {
            return .Invalid("Username and password are required.")
        }
        
        if user.username.count < minUsernameLength {
            return .Invalid("Username needs to be at least \(minUsernameLength) characters long")
        }
        
        if user.password.count < minPasswordLength {
            return .Invalid("Password needs to be at least \(minPasswordLength) characters long")
        }
        
        return .Valid
    }
    
    func login(type: RequestType,completion: @escaping (_ errorString: String?) -> Void) {
        switch type {
        case .Login:
            Auth.auth().signIn(withEmail: user.username, password: user.password, completion: { (user, error) in
                if user != nil {
                    completion(nil)
                } else {
                    if let currentError = error?.localizedDescription {
                        completion(currentError)
                    }
                }
            })
        case .SignUp:
            Auth.auth().createUser(withEmail: user.username, password: user.password, completion: { (user, error) in
                if user != nil {
                    completion(nil)
                }else {
                    if let currentError = error?.localizedDescription {
                        completion(currentError)
                    }
                }
            })
        }
    }
    
}

enum KeyPath: String {
    case user = "user"
}




















