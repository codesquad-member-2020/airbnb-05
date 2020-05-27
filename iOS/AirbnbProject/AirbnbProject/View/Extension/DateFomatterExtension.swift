//
//  DateFomatterExtension.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/24.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation

extension DateFormatter {
    func getYear(from: Date) -> Int {
        self.dateFormat = "yyyy"
        return Int(self.string(from: from))!
    }
    
    func getMonth(from: Date) -> Int {
        self.dateFormat = "MM"
        return Int(self.string(from: from))!
    }
    
    func getMonthAsString(from: Date) -> String {
        self.dateFormat = "MMMM"
        return self.string(from: from)
    }
}
