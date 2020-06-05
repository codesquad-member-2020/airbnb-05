//
//  DataUseCase.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/03.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

struct DataUseCase {
    static let imgCache = AutoPurgingImageCache()
    
    static func getCityList(manager: NetworkManager, completion: @escaping ([CityInfo]?) -> ()) {
        manager.requestData(url: EndPoints.requestCityList, method: .get, body: nil, paramData: nil) { (data, _, error) in
            guard let data = data else { completion(nil); return }
            
            let cityListInfo = try? JSONDecoder().decode(CityListInfo.self, from: data)
            completion(cityListInfo?.data)
        }
    }
    
    static func getAccomodationList(manager: NetworkManager, cityId: Int, paramData: [URLQueryItem], completion: @escaping ([RoomInfo]?) -> ()) {
        manager.requestData(url: EndPoints.requestAccomodationURL(cityId: cityId), method: .get, body: nil, paramData: paramData) { (data, _, error) in
            guard let data = data else { completion(nil); return }
            
            let accomodationListInfo = try? JSONDecoder().decode(AccomodationListInfo.self, from: data)
            completion(accomodationListInfo?.data)
        }
    }
    
    static func getPriceList(manager: NetworkManager, cityId: String, paramData: [URLQueryItem]?, completion: @escaping (PriceInfo?) -> ()) {
        manager.requestData(url: EndPoints.requestPriceURL(cityId: cityId), method: .get, body: nil, paramData: paramData) { (data, _, error) in
            guard let data = data else { completion(nil); return }
            
            guard let priceListInfo = try? JSONDecoder().decode(PriceListInfo.self, from: data) else {completion(nil); return }
            completion(priceListInfo.data)
        }
    }
    
    static func loadImg(manager: NetworkManager, imgUrl: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: imgUrl) else { return }
        let urlRequest = URLRequest(url: url)
        let cacheKey = self.imgCache.imageCacheKey(for: urlRequest, withIdentifier: nil)
        let image = self.imgCache.image(withIdentifier: cacheKey)
        
        if image != nil {
            completion(image)
        } else {
            manager.fetchImage(imgURL: urlRequest) { (image) in
                guard let image = image else { completion(nil); return }
                self.imgCache.add(image, withIdentifier: cacheKey)
                completion(image)
            }
        }
    }
    
    static func bookmarkAdd(manager: NetworkManager, roomid: Int, completion: @escaping (Bool) -> ()) {
        manager.requestData(url: EndPoints.requestBookmarkOnOff(roomId: roomid), method: .post, body: nil, paramData: nil) { (data, _, error) in
            guard let data = data else { completion(false); return }
            
            guard let bookMarkResponse = try? JSONDecoder().decode(Response.self, from: data) else { completion(false); return }
            if bookMarkResponse.status_code == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    static func bookmarkDelete(manager: NetworkManager, roomid: Int, completion: @escaping (Bool) -> ()) {
        manager.requestData(url: EndPoints.requestBookmarkOnOff(roomId: roomid), method: .delete, body: nil, paramData: nil) { (data, _, error) in
            guard let data = data else { completion(false); return }
            
            guard let bookMarkResponse = try? JSONDecoder().decode(Response.self, from: data) else { completion(false); return }
            
            if bookMarkResponse.status_code == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    static func requestBookmarkList(manager: NetworkManager, completion: @escaping ([RoomInfo]?) -> ()) {
        manager.requestData(url: EndPoints.requestBookMard, method: .get, body: nil, paramData: nil) { (data, _, error) in
            guard let data = data else { completion(nil); return }
            
            guard let bookmarkList = try? JSONDecoder().decode(AccomodationListInfo.self, from: data) else { completion(nil); return }
            completion(bookmarkList.data)
        }
    }
}
