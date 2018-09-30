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
//    case login
//    case register
//    case forgotPassword(String)
    case preAuthorize
    case getTerminals
}

extension UserEndpoints {
    func toString() -> String {
        switch self {
//        case .login:
//            return "\(Api.ssoBaseURL)/oauth/v2/token"
//        case .register:
//            return "\(Api.ssoBaseURL)/api/users"
//        case .forgotPassword(let email):
//            return "\(Api.ssoBaseURL)/api/users/\(email)/forgot-password-token"
        case .preAuthorize:
            return "\(Api.appBaseURL)/truncated/login"
        case .getTerminals:
            return "\(Api.appBaseURL)/truncated/terminals"
        }
    }
}
