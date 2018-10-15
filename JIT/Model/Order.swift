//
//  Order.swift
//  JIT
//
//  Created by Katerina on 10.10.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import ObjectMapper

public class Order: Mappable {
    
    public var id: Int = 0
    public var longitude: Double = 0
    public var latitude: Double = 0
    public var date_time: Int = 0
    public var order_number: String = ""
    public var cargo_type_id: Int = 0
    public var cargo_weight: Int = 0
    public var car_number: String = ""
    public var trailer_number: String = ""
    
    public init() {}
    
    required public init?(map: Map) {
        id                   <- map["id"]
        longitude            <- map["longitude"]
        latitude             <- map["latitude"]
        date_time            <- map["date_time"]
        order_number         <- map["order_number"]
        cargo_type_id        <- map["cargo_type_id"]
        cargo_weight         <- map["cargo_weight"]
        car_number           <- map["car_number"]
        trailer_number       <- map["trailer_number"]
    }
    
    public func mapping(map: Map) {
        id                  >>> map["id"]
        longitude           >>> map["longitude"]
        latitude            >>> map["latitude"]
        date_time           >>> map["date_time"]
        order_number        >>> map["order_number"]
        cargo_type_id       >>> map["cargo_type_id"]
        cargo_weight        >>> map["cargo_weight"]
        car_number          >>> map["car_number"]
        trailer_number      >>> map["trailer_number"]
    }
}

