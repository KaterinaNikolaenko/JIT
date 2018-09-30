//
//  Constants.swift
//  JIT
//
//  Created by Katerina on 16.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation

enum Constants {
    
    enum UserDefaults {
        static let token = "token"
        static let deviceID = "deviceID"
    }
    
    enum Segues {
        static let showTerminals = "showTerminals"
        static let showDetails = "showDetails"
    }
    
    enum Storyboards {
        static let main = "Main"
    }
    
    enum ViewControllers {
        static let terminalsViewController = "TerminalsViewController"
    }
    
    enum URLs {
        static let privacyPolicy = "https://jitplus.com.ua/ru/pages/privacy_policy"
    }
    
    enum Messages {
        static let no_internet_connection = "No internet connection"
        static let input_data_was_nil = "Response could not be serialized, input data was nil or zero length."
    }
}
