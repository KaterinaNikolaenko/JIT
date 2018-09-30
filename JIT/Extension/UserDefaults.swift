//
//  UserDefaults.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation

// MARK: - Token
extension UserDefaults {
    
    static var token: String? {
        get {
            return UserDefaults.standard.object(forKey: Constants.UserDefaults.token) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.token)
        }
    }
    
    static var deviceID: String? {
        get {
            return UserDefaults.standard.object(forKey: Constants.UserDefaults.deviceID) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.deviceID)
        }
    }
}
