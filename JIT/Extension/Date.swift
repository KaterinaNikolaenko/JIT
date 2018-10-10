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
