//
//  NetworkManager.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/03.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagable {
    func requestData(url: String, method: HTTPMethod, body: Data?, completion: @escaping (Data?, HTTPURLResponse?, NetworkErrorCase?) -> ())
}

enum NetworkErrorCase : Error {
    case InvalidURL
    case NotFound
    case RequestFail
}

enum EndPoints {
    static let basicEndPoint = "http://52.6.242.151:8080"
    static let requestCityList = basicEndPoint + "/cities"
}

class NetworkManager: NetworkManagable {
    
    func requestData(url: String, method: HTTPMethod, body: Data?, completion: @escaping (Data?, HTTPURLResponse?, NetworkErrorCase?) -> ()) {
        
        guard let url = URL(string: url) else { completion(nil, nil, .InvalidURL); return }
        
        AF.request(url, method: method, parameters: body)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success(_):
                    completion(response.data, response.response, nil)
                    
                case .failure(_):
                    completion(nil, response.response, .RequestFail)
                }
        }
    }
}

