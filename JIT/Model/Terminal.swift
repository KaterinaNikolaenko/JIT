//
//  Terminal.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation

struct Terminal: Parsable {
    
    typealias T = Terminal
    
    var id: Int
    var name: String
    var address: String
    
    static func fromJSON(_ json: [String : Any]) -> Terminal? {
        
            guard let id = json["id"] as? Int else {return nil}
            guard let name = json["name"] as? String else {return nil}
            guard let address = json["address"] as? String else {return nil}
            return Terminal(id: id, name: name, address: address)
    }
}

