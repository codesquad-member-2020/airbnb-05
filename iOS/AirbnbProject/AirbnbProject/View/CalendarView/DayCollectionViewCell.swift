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
    
    override var isSelected: Bool {
        didSet {
            if isSelected{
                self.updateSelectedCellBackgroundView()
            } else {
                initializeBackgroundView()
            }
        }
    }
    
    func updateSelectedCellBackgroundView() {
        let view = UIView()
        let path = UIBezierPath(rect: view.frame)
        path.move(to: CGPoint(x: self.frame.midX, y: self.frame.minY))
        path.addLine(to: CGPoint(x: self.frame.maxX, y: self.frame.minY))
        path.addLine(to: CGPoint(x: self.frame.maxX, y: self.frame.maxY))
        path.addLine(to: CGPoint(x: self.frame.midX, y: self.frame.maxY))
        path.close()
        path.fill()
        UIColor(named: "faintLightGray")?.setFill()
        self.addSubview(view)
        cellBackgroundView.cornerRadius = cellBackgroundView.frame.size.width / 2
        dayLabel.textColor = .white
        cellBackgroundView.backgroundColor = .darkGray
    }
    
    func initializeBackgroundView() {
        dayLabel.textColor = .black
        cellBackgroundView.cornerRadius = 0
        cellBackgroundView.backgroundColor = .clear
        rightBackgroundView.backgroundColor = .clear
        leftBackgroundView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        dayLabel.text = nil
        initializeBackgroundView()
        self.isUserInteractionEnabled = true
    }
    
    func updatePeriodCellBackgroundView() {
        self.backgroundColor = UIColor(named: "faintLightGray")
    }
    
    func updateSideEndCellBackgroundView(sideDirection: Direction) {
        switch sideDirection {
        case .left:
            leftBackgroundView.backgroundColor = .clear
            rightBackgroundView.backgroundColor = UIColor(named: "flaterLightGray")
        case .right:
            leftBackgroundView.backgroundColor = UIColor(named: "flaterLightGray")
            rightBackgroundView.backgroundColor = .clear
        }
    }
}

enum Direction {
    case left, right
}
