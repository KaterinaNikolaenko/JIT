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
        static let orderNumber = "orderNumber"
        static let dateString = "dateString"
        static let timeString = "timeString"
        static let isShowSplash = "isShowSplash"
        static let terminalTitle = "terminalTitle"
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
        static let sendDataViewController = "SendDataViewController"
    }
    
    enum URLs {
        static let privacyPolicy = "https://jitplus.com.ua/ru/pages/privacy_policy"
    }
    
    enum Messages {
        static let no_internet_connection = "No internet connection"
        static let input_data_was_nil = "Response could not be serialized, input data was nil or zero length."
        static let error = "Ошибка"
        static let no_internet = "Отсутствует интернет соединение. Проверьте соединение или попробуйте повторить действие позже."
        static let no_correct_data = "Необходимо выбрать корректное время"
        static let no_order = "Введите номер контракта / заказа"
        static let ok = "OK"
    }
    
    enum DateFormats {
        static let general = "dd-MM-yyyy"
        static let birthday = "dd MMM yyyy"
        static let serverBirthday = "yyyy-MM-dd"
        static let record = "HH:mm dd MMMM"
        static let graphsTimeLabel = "HH:mm"
        static let graphsShortTimeLabel = "H"
        static let graphsDayLabel = "E"
        static let graphsDayDateLabel = "d MMMM"
        static let lowGlucoseDaily = "HH"
        static let lowGlucoseMontly = "dd"
        static let timeInTargetDaily = "EEEE d, MMMM yyyy"
        static let timeInTargetWeekly = "yyyy"
        static let timeInTargetMontly = "MMMM yyyy"
    }
}
