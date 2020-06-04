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
    
    static func requestPriceURL(cityId: String) -> String {
        return requestCityList + "/\(cityId)/prices"
    }
    static func requestAccomodationURL(cityId: Int) -> String {
        return requestCityList + "/\(cityId)/rooms"
    }
    
    static func requestAccomodationList(offset: Int, checkIn: String?, checkOut: String?, guests: String?, minPrice: String?, maxPrice: String?) -> Data {
        var param = [String:String]()
        
        param["limit"] = "10"
        param["offset"] = String(offset)
        
        if checkOut != nil {
            param["checkIn"] = checkIn
            param["checkOut"] = checkOut
        }
        if guests != nil {
            param["guests"] = guests!
        }
        if maxPrice != nil {
            param["minPrice"] = minPrice!
            param["maxPrice"] = maxPrice!
        }
        
        return try! JSONEncoder().encode(param)
    }
    
    static func requestPriceList(checkIn: String?, checkOut: String?, guests: Int?) -> Data? {
        var param = [String:String]()
        
        if checkOut != nil {
            param["checkIn"] = checkIn
            param["checkOut"] = checkOut
        }
        if guests != nil {
            param["guests"] = String(guests!)
        }
        
        if param.isEmpty {
            return nil
        }
        
        return try? JSONEncoder().encode(param)
    }
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

