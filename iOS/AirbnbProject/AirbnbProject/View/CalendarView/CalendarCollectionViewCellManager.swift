//
//  CalendarCollectionViewCellManager.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/30.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation
import UIKit

class CalendarCollectionViewCellManager {
//    private var cellDateType: CellDateType?
    var checkInCellIndexPath: IndexPath?
    var checkOutCellIndexPath: IndexPath?
    
    
    func fetchMarkedCellViewConfiguration(cellType: CellBackgroundType) -> DateCellViewInfo {
        switch cellType {
        case .checkIn : return DateCellViewInfo(cellBackgroundViewColor: .darkGray, leftBackgroundViewColor: .clear, rightBackgroundViewColor: UIColor.faintLightGray!, isCircle: true, labelTextColor: .white, userInteractionEnabled: true)
        case .checkOut : return DateCellViewInfo(cellBackgroundViewColor: .darkGray, leftBackgroundViewColor: UIColor.faintLightGray!, rightBackgroundViewColor: .clear, isCircle: true, labelTextColor: .white, userInteractionEnabled: true)
        case .included : return DateCellViewInfo(cellBackgroundViewColor: UIColor.faintLightGray!, leftBackgroundViewColor: .clear, rightBackgroundViewColor: .clear, isCircle: false, labelTextColor: .black, userInteractionEnabled: true)
        case .selected: return DateCellViewInfo(cellBackgroundViewColor: .darkGray, leftBackgroundViewColor: .clear, rightBackgroundViewColor: .clear, isCircle: true, labelTextColor: .white, userInteractionEnabled: true)
        case .deselected: return DateCellViewInfo(cellBackgroundViewColor: .clear, leftBackgroundViewColor: .clear, rightBackgroundViewColor: .clear, isCircle: false, labelTextColor: .black, userInteractionEnabled: true)
        case .userInteractionUnabled:
            return DateCellViewInfo(cellBackgroundViewColor: .clear, leftBackgroundViewColor: .clear, rightBackgroundViewColor: .clear, isCircle: false , labelTextColor: .lightGray, userInteractionEnabled: false)
        }
    }
    
}

enum CellBackgroundType {
    case selected
    case deselected
    case checkIn
    case checkOut
    case included
    case userInteractionUnabled
}

struct DateCellViewInfo{
    let cellBackgroundViewColor: UIColor
    let leftBackgroundViewColor: UIColor
    let rightBackgroundViewColor: UIColor
    let isCircle: Bool
    let labelTextColor: UIColor
    let userInteractionEnabled: Bool
}
