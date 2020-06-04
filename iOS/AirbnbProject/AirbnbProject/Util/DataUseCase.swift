//
//  DataUseCase.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/03.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation

struct DataUseCase {
    static func getCityList(manager: NetworkManager, completion: @escaping ([CityInfo]?) -> ()) {
        manager.requestData(url: EndPoints.requestCityList, method: .get, body: nil) { (data, _, error) in
            guard let data = data else { completion(nil); return }
            
            let cityListInfo = try? JSONDecoder().decode(CityListInfo.self, from: data)
            completion(cityListInfo?.data)
        }
    }
    
    static func getAccomodationList(manager: NetworkManager, cityId: Int, paramData: Data, completion: @escaping ([RoomInfo]?) -> ()) {
        manager.requestData(url: EndPoints.requestAccomodationURL(cityId: cityId), method: .get, body: paramData) { (data, _, error) in
            guard let data = data else { completion(nil); return }
            
            let accomodationListInfo = try? JSONDecoder().decode(AccomodationListInfo.self, from: data)
            completion(accomodationListInfo?.data)
        }
    }
    
    static func getPriceList(manager: NetworkManager, cityId: String, paramData: Data?, completion: @escaping (PriceInfo?) -> ()) {
        manager.requestData(url: EndPoints.requestPriceURL(cityId: cityId), method: .get, body: paramData) { (data, _, error) in
            guard let data = data else { completion(nil); return }
            
            guard let priceListInfo = try? JSONDecoder().decode(PriceListInfo.self, from: data) else {completion(nil); return }
            completion(priceListInfo.data)
        }
    }
}
