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

    static let identifier = "DayCollectionViewCell"

    override var isSelected: Bool {
        didSet {
            if isSelected{
                self.setupCellBackgroundView()
            } else {
                initializeBackgroundView()
            }
        }
    }
    
    func setupCellBackgroundView() {
        cellBackgroundView.cornerRadius = cellBackgroundView.frame.size.width / 2
        cellBackgroundView.backgroundColor = .darkGray
    }
    
    func initializeBackgroundView() {
        cellBackgroundView.backgroundColor = .clear
    }
}
