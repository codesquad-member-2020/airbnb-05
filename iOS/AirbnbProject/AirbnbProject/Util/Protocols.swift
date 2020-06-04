//
//  Protocols.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/06/04.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation

@objc protocol SendDataDelegate {
    @objc optional func sendData(data: String)
    @objc optional func sendDate(first: String, second: String)
    @objc optional func sendPrice(first: String, second: String)
}
