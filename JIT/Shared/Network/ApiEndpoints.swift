//
//  ApiEndpoints.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - User
enum UserEndpoints {
    case preAuthorize
    case getTerminals
    case sendLocation
    case sendTripData
    case finishTrip
}

extension UserEndpoints {
    
    func toString() -> String {
        
        switch self {
        case .preAuthorize:
            return "\(Api.appBaseURL)/truncated/login"
        case .getTerminals:
            return "\(Api.appBaseURL)/truncated/terminals"
        case .sendLocation:
            return "\(Api.appBaseURL)/truncated/location"
        case .sendTripData:
            return "\(Api.appBaseURL)/truncated/trip_data"
        case .finishTrip:
            return "\(Api.appBaseURL)/truncated/trip_finish"
        }
    }
}
