//
//  CalendarCollectionViewManager.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/25.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation

class CalenderCollectionViewManager {
    
    private let calendar = Calendar.init(identifier: .gregorian)
    private let formatter = DateFormatter()
    private let currMonth: Date
    private let numberToAdjustFirstDay = 2
    private let numberToAdjustNextDay = 3
    private let firstDayPosition: Int
    private let currentDate: Int
    private var firstWeekDay: Int
    private let dayCount: Int
    
    init(section: Int) {
        self.currMonth = Calendar.current.date(byAdding: .month, value: section, to: Date())!
        let startDate = Date().getStartDayInMonth(year: formatter.getYear(from: currMonth), month: formatter.getMonth(from: currMonth))
        
        self.firstWeekDay = calendar.dateComponents([.year, .month, .weekday], from: startDate).weekday!
        if firstWeekDay == 1 {
            self.firstWeekDay = 8
        }
        self.firstDayPosition = firstWeekDay - numberToAdjustFirstDay
        self.currentDate = currMonth.getTodayDate(date: currMonth)
        self.dayCount = (Calendar.current.range(of: .day, in: .month, for: currMonth)?.count)!
    }
    
    func setCellHiddenStatus(row : Int) -> Bool {
        if firstDayPosition > row || dayCount + firstDayPosition <= row {
            return true
        } else {
            return false
        }
    }
    
    func getYesterdayDatePosition() -> IndexPath {
        let yesterdayDatePosition = IndexPath(row: currentDate + firstDayPosition - 1, section: 0)
        return yesterdayDatePosition
    }
    func setCellday(row: Int) -> String {
        return String(row - self.firstWeekDay + numberToAdjustNextDay)
    }
    
    func setSectionHeaderLabel() -> String {
        let year = formatter.getYear(from: currMonth)
        let month = formatter.getMonthAsString(from: currMonth)
        
        return "\(month) \(year)"
    }
}

