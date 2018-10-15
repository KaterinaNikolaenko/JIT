//
//  Date.swift
//  JIT
//
//  Created by Katerina on 11.10.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation

extension Date {
    
    func createStringWithFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension Date {
    
    static func combineDate(date: Date, withTime time: Date) -> Date? {
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        var dateComponents = gregorian?.components([.year, .month, .day], from: date)
        let timeComponents = gregorian?.components([.hour, .minute, .second], from: time)
        
        dateComponents?.second = timeComponents?.second ?? 0
        dateComponents?.minute = timeComponents?.minute ?? 0
        dateComponents?.hour = timeComponents?.hour ?? 0
        
        if let _ = dateComponents {
            return gregorian?.date(from: dateComponents!)
        }
        return nil
    }
}
