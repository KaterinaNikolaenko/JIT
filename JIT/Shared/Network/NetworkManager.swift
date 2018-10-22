//
//  NetworkManager.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import Alamofire

typealias ApiJSONResponse = (Result<[String : Any]?>) -> ()

class NetworkManager {
    
    private var manager : SessionManager?
    static let shared = NetworkManager()
    
    init() {
        let configuration = Timberjack.defaultSessionConfiguration()
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    private func httpHeaders() -> HTTPHeaders? {
        
        var headers = HTTPHeaders()
        if let token = UserDefaults.token {
            headers[HeaderKey.auth] = token
        }
        return headers
    }
    
    @discardableResult
    func request(_ apiRequest: ApiRequest, completion: @escaping ApiJSONResponse) -> DataRequest? {
        
        if !self.isReachable() {
            completion(Result.failure(generalApiError(Constants.Messages.no_internet_connection, code: .noInternet)))
            return nil
        }
        let newRequest = manager?.request(apiRequest.path, method: apiRequest.method, parameters: apiRequest.parameters,
                                          encoding: apiRequest.encoding, headers: self.httpHeaders()).responseJSON(completionHandler: { [unowned self] (response) in
                                            switch response.result {
                                            case .success(let result):
                                                let tempResult = result as? [String : Any]
                                                if let success = tempResult?["success"] as? Bool {
                                                    if success {
                                                        completion(Result.success(result as? [String : Any] ?? [:]))
                                                    } else {
                                                        if let error = tempResult?["error"] as? [String : Any] {
                                                            let errorMessage = error["message"] as? String ?? ""
                                                            let errorCodeInt = error["code"] as? Int ?? 404
                                                            let errorCode = ErrorCode(rawValue: errorCodeInt) ?? .notFound
                                                            completion(Result.failure(self.generalApiError(errorMessage, code: errorCode)))
                                                        } else {
                                                            completion(Result.failure(self.generalApiError("", code: .notFound)))
                                                        }
                                                    }
                                                } else {
                                                    completion(Result.success(result as? [String : Any] ?? [:]))
                                                }
                                            case .failure(let error):
                                                if error.localizedDescription == ApiErrorKeys.emptyData {
                                                    completion(Result.success([:]))
                                                    return
                                                }
                                                completion(Result.failure(self.generalApiError(error.localizedDescription, code: .notFound)))
                                            }
                                            
                                          })
        return newRequest
    }
    
    private func isReachable() -> Bool {
        
        if let manager = NetworkReachabilityManager(){
            return manager.isReachable
        }
        return false
    }
    
    private func generalApiError(_ message: String, code: ErrorCode) -> ApiError {
        
        return ApiError(code: code, message: message, messageRu: "", status: 0, json: nil)
    }
}

private enum ApiErrorKeys {
    
    static let emptyData = Constants.Messages.input_data_was_nil
}
