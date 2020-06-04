//
//  BookingManager.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/28.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation

class BookingManager {
    
    var firstSelectedCellIndexPath: IndexPath?
    var secondSelectedCellIndexPath: IndexPath? {
        didSet {
            NotificationCenter.default.post(name: .selectedCheckoutDate, object: self)
        }
    }
    var selectedIndexPath = [IndexPath]()
    var selectedCells = [IndexPath : DayCollectionViewCell]()
    
    func initializeCell(indexPath: IndexPath) {
        self.secondSelectedCellIndexPath = nil
        self.firstSelectedCellIndexPath = nil
        self.selectedCells[indexPath] = nil
    }
    
    func isSelectedCell(indexPath: IndexPath, cell: DayCollectionViewCell) -> Bool {
        if selectedCells[indexPath] == cell {
            self.initializeCell(indexPath: indexPath)
            return true
        } else {
            return false
        }
    }
    
    func setFirstSelectedIndexPath(indexPath: IndexPath, cell: DayCollectionViewCell) {
        self.selectedCells[indexPath] = cell
        self.selectedIndexPath.append(indexPath)
        self.firstSelectedCellIndexPath = self.selectedIndexPath[0]
    }
    
    func isSelectable(indexPath: IndexPath) {
        if self.firstSelectedCellIndexPath! > indexPath {
            selectedCells[firstSelectedCellIndexPath!]?.initializeBackgroundView()
            self.initializeCell(indexPath: firstSelectedCellIndexPath!)
            
            selectedIndexPath.remove(at: 0)
            self.firstSelectedCellIndexPath = indexPath
        }
    }
    
    private func collectSelectedCell(row from: Int , to: Int, in section: Int) {
        for bookingDateCellRow in from ... to {
            let cellIndexPath = IndexPath(row: bookingDateCellRow, section: section)
            self.selectedIndexPath.append(cellIndexPath)
        }
    }
    
    func checkSelectedDatesSameMonth(numberOfItemsInSection: Int) {
        if self.secondSelectedCellIndexPath != nil {
            if self.firstSelectedCellIndexPath!.section == self.secondSelectedCellIndexPath!.section {
                
                self.collectSelectedCell(row: firstSelectedCellIndexPath!.row, to: secondSelectedCellIndexPath!.row, in: self.firstSelectedCellIndexPath!.section)
            } else {
                self.collectSelectedCell(row: firstSelectedCellIndexPath!.row, to: numberOfItemsInSection, in: self.firstSelectedCellIndexPath!.section)
                
                self.collectSelectedCell(row: 0, to: secondSelectedCellIndexPath!.row, in: secondSelectedCellIndexPath!.section)
            }
        }
    }
    
    func initializeAll() {
        firstSelectedCellIndexPath = nil
        secondSelectedCellIndexPath = nil
        selectedCells = [:]
        selectedIndexPath.removeAll()
    }
    
    func defineCellType(completion: (IndexPath, CellBackgroundType) ->()) {
        for indexPath in self.selectedIndexPath {
            if indexPath == self.firstSelectedCellIndexPath {
                completion(indexPath , .checkIn)
            } else if indexPath == self.secondSelectedCellIndexPath {
                completion(indexPath, .checkOut)
            } else {
                completion(indexPath, .included)
            }
        }
    }
    
    func getCheckInDay() -> String {
        guard let checkInDay = firstSelectedCellIndexPath else { return "Check In" }
        var day = selectedCells[checkInDay]!.dayLabel.text!
        if Int(day)! < 10 {
            day = "0"+day
        }
        
        return day
    }
    
    func getCheckOutDay() -> String {
        guard let checkOutDay = secondSelectedCellIndexPath else { return "Check Out" }
        var day = selectedCells[checkOutDay]!.dayLabel.text!
        if Int(day)! < 10 {
            day = "0"+day
        }
        return day
    }
    
    func isSelectedAllDate() -> Bool {
        if self.firstSelectedCellIndexPath != nil && self.secondSelectedCellIndexPath != nil {
            return true
        } else {
            return false
        }
    }
    
    func setSecondSelectedIndexPath(indexPath: IndexPath) {
        if self.firstSelectedCellIndexPath != nil && self.secondSelectedCellIndexPath == nil {
            self.secondSelectedCellIndexPath = indexPath
        }
    }
}

extension Notification.Name {
    static let selectedCheckoutDate = Notification.Name("seledctedCheckoutDate")
}
