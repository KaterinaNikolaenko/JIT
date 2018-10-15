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
    
    static var order: String? {
        get {
            return UserDefaults.standard.object(forKey: Constants.UserDefaults.orderNumber) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.orderNumber)
        }
    }
    
    static var terminalTitle: String? {
        get {
            return UserDefaults.standard.object(forKey: Constants.UserDefaults.terminalTitle) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.terminalTitle)
        }
    }
    
    static var selectedDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: Constants.UserDefaults.selectedDate) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.selectedDate)
        }
    }
    
    static var selectedTime: Date? {
        get {
            return UserDefaults.standard.object(forKey: Constants.UserDefaults.selectedTime) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.selectedTime)
        }
    }
    
    static var isShowSplash: Bool? {
        get {
            return UserDefaults.standard.object(forKey: Constants.UserDefaults.isShowSplash) as? Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.isShowSplash)
        }
    }
}
