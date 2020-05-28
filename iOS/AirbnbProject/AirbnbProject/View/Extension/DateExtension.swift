//
//  DateExtension.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/24.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation

extension Date {
    func getStartDayInMonth(year: Int, month: Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 2
        return calendar.date(from: components)!
    }
    
    func getTodayDate(date: Date) -> Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return day
    }
}
