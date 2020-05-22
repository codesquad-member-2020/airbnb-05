//
//  countButtonManager.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/22.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation
import UIKit

class CountButtonManager {
    enum active {
        case plus
        case minus
    }
    private let minCount = 0
    private let maxCount = 8
    
    var plusButtonTintColor: UIColor = .gray
    var minusButtonTintColor: UIColor = .gray
    var count: Int
    var isPlusEnable: Bool = true
    var isMinusEnable: Bool = true
    
    init(currentCount: String, acitve: active) {
        self.count = Int(currentCount)!
        
        switch acitve {
        case .plus:
            count += 1
            if count == maxCount {
                isPlusEnable = false
                plusButtonTintColor = .lightGray
            }
            break
        case .minus:
            count -= 1
            if count == minCount {
                isMinusEnable = false
                minusButtonTintColor = .lightGray
            }
            break
        }
    }
}
