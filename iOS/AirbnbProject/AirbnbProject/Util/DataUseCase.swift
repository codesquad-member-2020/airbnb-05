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
            
            let decodedData = try? JSONDecoder().decode(CityListInfo.self, from: data)
            completion(decodedData?.data)
        }
    }
}
