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
        case initialize
    }
    private let minCount = 0
    private let maxCount = 8
    
    var plusButtonTintColor: UIColor = .gray
    var minusButtonTintColor: UIColor = .gray
    var count: Int
    var isPlusEnable: Bool = true
    var isMinusEnable: Bool = true
    
    init(currentCount: String?, acitve: active) {
        if currentCount == nil {
            self.count = 0
        } else {
            self.count = Int(currentCount!)!
        }
        
        switch acitve {
        case .plus:
            self.count += 1
            if self.count == maxCount {
                isPlusEnable = false
                plusButtonTintColor = .lightGray
            }
            break
        case .minus:
            self.count -= 1
            if self.count == minCount {
                isMinusEnable = false
                minusButtonTintColor = .lightGray
            }
            break
        case .initialize:
            minusButtonTintColor = .lightGray
            isMinusEnable = false
        }
    }
}
