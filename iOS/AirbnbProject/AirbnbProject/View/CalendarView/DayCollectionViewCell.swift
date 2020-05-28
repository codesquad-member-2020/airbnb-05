//
//  DayCollectionViewCell.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/23.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var leftBackgroundView: UIView!
    @IBOutlet weak var rightBackgroundView: UIView!
    
    static let identifier = "DayCollectionViewCell"
    
    var dateInfo: CellDateInfo?
        
    func updateSelectedCellBackgroundView() {
        cellBackgroundView.cornerRadius = cellBackgroundView.frame.size.width / 2
        dayLabel.textColor = .white
        cellBackgroundView.backgroundColor = .darkGray
    }
    
    func initializeBackgroundView() {
        dayLabel.textColor = .black
        cellBackgroundView.cornerRadius = 0
        self.cellBackgroundView.backgroundColor = .clear
        rightBackgroundView.backgroundColor = .clear
        leftBackgroundView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        
        dayLabel.text = nil
        dayLabel.textColor = .black
        initializeBackgroundView()
        self.isUserInteractionEnabled = true
    }
    
    func updatePeriodCellBackgroundView() {
        self.cellBackgroundView.cornerRadius = 0
        dayLabel.textColor = .black
        self.cellBackgroundView.backgroundColor = UIColor(named: CustomColor.faintLightGray)
    }
    
    func updateSideEndCellBackgroundView(sideDirection: Direction) {
        dayLabel.textColor = .white
        switch sideDirection {
        case .left:
            leftBackgroundView.backgroundColor = .clear
            rightBackgroundView.backgroundColor = UIColor(named: CustomColor.faintLightGray)
        case .right:
            leftBackgroundView.backgroundColor = UIColor(named: CustomColor.faintLightGray)
            rightBackgroundView.backgroundColor = .clear
        }
    }
    
    func updateDisabledCell() {
        self.dayLabel.textColor = .lightGray
        self.isUserInteractionEnabled = false
    }
}

enum Direction {
    case left, right
}

struct CellDateInfo {
    let year: Int
    let month: Int
    let day: Int
}

enum CustomColor {
    static let faintLightGray = "faintLightGray"
}
