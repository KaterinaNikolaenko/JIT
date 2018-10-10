//
//  JsonMapper.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation

struct JsonMapper<T: Parsable> {
    
    typealias MapperConstructor = (_ JSON: [String : Any]) -> Any
    
    static func parseArray(_ dictionary: [[String : Any]], constructor: MapperConstructor) -> [T] {
        var outArray: [T] = []
        
        for d in dictionary {
            if let object = constructor(d) as? T {
                outArray.append(object)
            }
        }
        return outArray
    }
    
    static func parseObject(_ dictionary: [String : Any], constructor:  @escaping MapperConstructor)  -> (T) {
        guard let object = constructor(dictionary) as? T else {
            return constructor([:]) as! (T)
        }
        return object
    }
}
