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
    
    let today: Int
    
    init(indexPath: IndexPath) {
        self.currMonth = Calendar.current.date(byAdding: .month, value: indexPath.section, to: Date())!
        
        let startDate = Date().getStartDayInMonth(year: formatter.getYear(from: currMonth), month: formatter.getMonth(from: currMonth))
        
        let firstWeekDay = calendar.dateComponents([.weekday], from: startDate).weekday!
        
        self.firstDayPosition = firstWeekDay - numberToAdjustFirstDay
        self.today = indexPath.row - firstWeekDay + numberToAdjustNextDay
        self.currentDate = currMonth.getTodayDate(date: currMonth)
    }
    
    func setCellHiddenStatus(indexPath: IndexPath) -> Bool {
        if firstDayPosition > indexPath.item {
            return true
        } else {
            return false
        }
    }
    
    func getYesterdayDatePosition() -> IndexPath {
        let yesterdayDatePosition = IndexPath(row: currentDate + firstDayPosition - 1, section: 0)
        return yesterdayDatePosition
    }
}
