//
//  ApiModels.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import Alamofire

enum Api {
    static let appBaseURL = "https://jitplus.com.ua/api"
}

protocol KeyValuedObject {
    var key: String {get set}
    var value: Any {get set}
}

struct SimpleKeyValuedObject: KeyValuedObject {
    var key: String
    var value: Any
}

struct ApiRequest {
    let method: HTTPMethod
    let path: String
    var parameters: Parameters
    let encoding: ParameterEncoding
    
    init(method: HTTPMethod = .get, path: String, parameters: Parameters = [:], encoding: ParameterEncoding = URLEncoding.default) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.encoding = encoding
    }
}

struct PagingModel {
    var count: Int
    var limit: Int
    var page: Int
    
    init(count: Int = 0, limit: Int = 15, page: Int = 1) {
        self.count = count
        self.limit = limit
        self.page = page
    }
}

enum Result<T> {
    case success(T)
    case failure(ApiError)
}

struct ApiError: Error {
    var code: ErrorCode
    var message: String
    var messageRu: String
    var status: Int
    var json: [String : Any]?
}

enum DataRetrievingState {
    case loading
    case success
    case failure
}

enum HeaderKey {
    static let auth = "Authorization-token"
}

enum ErrorCode: Int {
    
    case defaultCode = 0
    
//    case methodIsNotImplemented = 887
//    case errorParsing = 888
//    case failedSaveCoreData = 889
    case noInternet = 890
//
//    case invalidToken = 997
//    case invalidFields = 998
//    case unverifiedEmail = 999
//    case unfilledRequiredField = 1000
//    case exceededNumberOfResumes = 1001
//    case maintenance = 1005
//    case unsupportedAppVersion = 1006
//
//    case unauthorized = 401
//    case invalidEntityId = 403
    case notFound = 404
    case TRIP_NOT_FOUND = 800
    case TERMINAL_NOT_FOUND = 801
    case VALIDATION = 802
    case TRIP_WAS_STARTED = 803
    case TRIP_ORDER_NUMBER_NOT_VALID = 804
    case TERMINAL_WAS_DELETED = 805
}
