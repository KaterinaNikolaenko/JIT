//
//  ApiService.swift
//  JIT
//
//  Created by Katerina on 30.09.18.
//  Copyright © 2018 JIT+. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    let networkManager = NetworkManager.shared
    
    func preauthorize() {
        var params: [String : Any] = [:]
        params["device_id"] = UserDefaults.deviceID
        
        let request = ApiRequest(method: .post, path: UserEndpoints.preAuthorize.toString(), parameters: params, encoding: URLEncoding.default)
        
        networkManager.request(request) { (result) in
            switch result {
            case .success(let json):
                if let token = json?["authorization_token"] as? String {
                    UserDefaults.token = token
                }
                return
            case .failure(let error):
                return
            }
        }
    }
    
    func getTerminals(_ completion: @escaping (Result<Void>) -> Void) {
        let request = ApiRequest(method: .get, path: UserEndpoints.getTerminals.toString(), parameters: [:])
        networkManager.request(request) { (result) in
            switch result {
            case .success(let json):
                completion(Result.success(()))
                return
            case .failure(let error):
                completion(Result.failure(error))
                return
            }
        }
    }
}
