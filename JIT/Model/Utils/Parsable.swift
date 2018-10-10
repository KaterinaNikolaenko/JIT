//
//  Parsable.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
//import ObjectMapper

protocol Parsable {
    associatedtype T
    
    static func fromJSON(_ json: [String: Any]) -> T?
}

extension Parsable {
    
    static func parseModel<T: Parsable>(_ json: [String : Any], type: T.Type) -> T {
        
        let model = JsonMapper<T>.parseObject(json, constructor: {T.fromJSON($0) as Any})
        return model
    }
    
    static func parseModelArray<T: Parsable>(_ json: [[String : Any]]) -> [T] {
        
        let model = JsonMapper<T>.parseArray(json, constructor: {T.fromJSON($0) as Any})
        return model
    }
}
