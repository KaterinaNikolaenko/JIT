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
                                          encoding: apiRequest.encoding, headers: self.httpHeaders())
        
        newRequest?.validate(statusCode: 0...300).responseJSON(completionHandler: { [unowned self] (response) in
            switch response.result {
            case .success(let result):
                completion(Result.success(result as? [String : Any] ?? [:]))
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
    
//    private func catchErrors(_ error: ApiError) {
//        switch error.code {
//        case .unauthorized, .invalidToken:
//            //            let wrapper = GeneralAlertWrapper(title: "Oops", message: error.message, handler: {
//            //                UserWorker.logout()
//            //            })
//            //            wrapper.show()
//            break
//        default:
//            break
//        }
//    }
    
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
