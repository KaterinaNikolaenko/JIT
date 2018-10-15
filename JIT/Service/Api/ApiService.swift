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
    
    func preauthorize(_ completion: @escaping (Result<Void>) -> Void) {
        
        var params: [String : Any] = [:]
        params["device_id"] = UserDefaults.deviceID
        
        let request = ApiRequest(method: .post, path: UserEndpoints.preAuthorize.toString(), parameters: params, encoding: URLEncoding.default)
        
        networkManager.request(request) { (result) in
            switch result {
            case .success(let json):
                if let token = json?["authorization_token"] as? String {
                    UserDefaults.token = token
                }
                completion(Result.success(()))
                return
            case .failure(let error):
                completion(Result.failure(error))
                return
            }
        }
    }
    
    func getTerminals(_ completion: @escaping (Result<[String: Any]?>) -> Void) {
        
        let request = ApiRequest(method: .get, path: UserEndpoints.getTerminals.toString(), parameters: [:])
        networkManager.request(request) { (result) in
            switch result {
            case .success(let json):
                completion(Result.success(json))
                return
            case .failure(let error):
                completion(Result.failure(error))
                return
            }
        }
    }
    
    func sendLocation(longitude: String, latitude: String, time: String, _ completion: @escaping (Result<Void>) -> Void) {
        
        var params: [String : Any] = [:]
        params["longitude"] = longitude
        params["latitude"] = latitude
        params["time"] = time
        
        let request = ApiRequest(method: .post, path: UserEndpoints.sendLocation.toString(), parameters: params, encoding: URLEncoding.default)
        
        networkManager.request(request) { (result) in
            switch result {
            case .success(_):
                completion(Result.success(()))
                return
            case .failure(let error):
                completion(Result.failure(error))
                return
            }
        }
    }
    
    func sendTripData(order: Order, _ completion: @escaping (Result<Void>) -> Void) {
        
        let request = ApiRequest(method: .post, path: UserEndpoints.sendTripData.toString(), parameters: order.toJSON(), encoding: URLEncoding.default)
        
        networkManager.request(request) { (result) in
            switch result {
            case .success(_):
                completion(Result.success(()))
                return
            case .failure(let error):
                completion(Result.failure(error))
                return
            }
        }
    }
    
    func finishTrip(idOrder: String, longitude: String, latitude: String, date_time: Int, _ completion: @escaping (Result<Void>) -> Void) {
        
        var params: [String : Any] = [:]
        params["id"] = idOrder
        params["longitude"] = longitude
        params["latitude"] = latitude
        params["date_time"] = date_time
        
        let request = ApiRequest(method: .post, path: UserEndpoints.finishTrip.toString(), parameters: params, encoding: URLEncoding.default)
        
        networkManager.request(request) { (result) in
            switch result {
            case .success(_):
                completion(Result.success(()))
                return
            case .failure(let error):
                completion(Result.failure(error))
                return
            }
        }
    }
}
