//
//  NetworkManager.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/03.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

protocol NetworkManagable {
    func requestData(url: String, method: HTTPMethod, body: Data?, paramData: [URLQueryItem]?, completion: @escaping (Data?, HTTPURLResponse?, NetworkErrorCase?) -> ())
}

enum NetworkErrorCase : Error {
    case InvalidURL
    case NotFound
    case RequestFail
}

enum EndPoints {
    static let basicEndPoint = "http://52.6.242.151:8080"
    static let requestCityList = basicEndPoint + "/cities"
    static let requestBookMard = basicEndPoint + "/bookmarks"
    static let oauthLogin = "https://github.com/login/oauth/authorize?client_id=1b7982028f6ef8e3a91a&scope=user%20public_repo"
    static func requestPriceURL(cityId: String) -> String {
        return requestCityList + "/\(cityId)/prices"
    }
    static func requestAccomodationURL(cityId: Int) -> String {
        return requestCityList + "/\(cityId)/rooms?"
    }
    static func requestBookmarkOnOff(roomId: Int) -> String {
        return requestBookMard + "/\(roomId)"
    }
    
    static func requestAccomodationList(offset: Int, checkIn: String?, checkOut: String?, guests: Int?, minPrice: String?, maxPrice: String?) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "limit", value: "10"))
        queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
        
        if checkOut != nil {
            queryItems.append(URLQueryItem(name: "checkIn", value: checkIn))
            queryItems.append(URLQueryItem(name: "checkOut", value: checkOut))
        }
        if guests != nil {
            queryItems.append(URLQueryItem(name: "guests", value: "\(guests!)"))
        }
        if maxPrice != nil {
            queryItems.append(URLQueryItem(name: "minPrice", value: minPrice))
            queryItems.append(URLQueryItem(name: "maxPrice", value: maxPrice))
        }
        
        return queryItems
    }
    
    static func requestPriceList(checkIn: String?, checkOut: String?, guests: Int?) -> [URLQueryItem]? {
        var queryItems = [URLQueryItem]()
        
        if checkOut != nil {
            queryItems.append(URLQueryItem(name: "checkIn", value: checkIn))
            queryItems.append(URLQueryItem(name: "checkOut", value: checkOut))
        }
        if guests != nil {
            queryItems.append(URLQueryItem(name: "guests", value: "\(guests!)"))
        }
        
        if queryItems.isEmpty {
            return nil
        }
        
        return queryItems
    }
}

class NetworkManager: NetworkManagable {
    
    private let token = "Bearer \(UserDefaults.standard.object(forKey: "JWTToken")!)"
    private let imageCache = AutoPurgingImageCache()
    
    func requestData(url: String, method: HTTPMethod, body: Data?, paramData: [URLQueryItem]?, completion: @escaping (Data?, HTTPURLResponse?, NetworkErrorCase?) -> ()) {
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = paramData
        
        guard let url = urlComponents?.url else { completion(nil, nil, .InvalidURL); return }
        let header: HTTPHeaders = ["Authorization" : self.token, "Accept": "application/json"]
    
        AF.request(url, method: method, parameters: body, headers: header)
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
    
    func fetchImage(imgURL: URLRequest, completion: @escaping (UIImage?) -> ()) {
        AF.request(imgURL)
            .validate()
            .responseImage { (response) in
                switch response.result {
                case .success(let image):
                    completion(image)
                case .failure(_):
                    completion(nil)
                }
        }
        
    }
}

