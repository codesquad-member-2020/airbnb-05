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
    
    var viewConfiguration: DateCellViewInfo? {
        didSet {
            updateCellViewWithConfiguration()
        }
    }
    var dateInfo: CellDateInfo?
    
    private func updateCellViewWithConfiguration() {
        guard let viewConfiguration = viewConfiguration else { return }
        self.cellBackgroundView.backgroundColor = viewConfiguration.cellBackgroundViewColor
        self.leftBackgroundView.backgroundColor = viewConfiguration.leftBackgroundViewColor
        self.rightBackgroundView.backgroundColor = viewConfiguration.rightBackgroundViewColor
        if viewConfiguration.isCircle == true {
            self.cellBackgroundView.cornerRadius = self.frame.size.width / 2
        } else {
            self.cellBackgroundView.cornerRadius = 0
        }
        self.dayLabel.textColor = viewConfiguration.labelTextColor
        self.isUserInteractionEnabled = viewConfiguration.userInteractionEnabled
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
}

extension UIColor {
    static let faintLightGray = UIColor(named: "faintLightGray")
}

struct CellDateInfo {
    let year: Int
    let month: Int
    let day: Int
}
