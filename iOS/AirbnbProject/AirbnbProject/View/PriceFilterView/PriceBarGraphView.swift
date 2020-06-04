//
//  PriceBarGraphView.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/02.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class PriceBarGraphView: UIView {
    
    var numberOfAccommodationByPriceRange: [CGFloat] = [] {
        didSet {
            drawPriceBarGraph()
        }
    }
    var graphWidth = CGFloat()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
    }

    override func draw(_ rect: CGRect) {
        drawPriceBarGraph()
    }
    
    func drawPriceBarGraph() {
        let width = self.frame.width / CGFloat((numberOfAccommodationByPriceRange.count * 2 - 1))
        for (index, numberOfAccomodation) in numberOfAccommodationByPriceRange.enumerated(){
            let path = UIBezierPath()
            path.lineWidth = 3
            UIColor.gray.set()
            path.move(to: CGPoint(x: CGFloat((index * 2)) * width, y: frame.height))
            path.addLine(to: CGPoint(x: CGFloat((index * 2)) * width + width, y: frame.height))
            path.addLine(to: CGPoint(x: CGFloat((index * 2)) * width + width, y: frame.height - (numberOfAccomodation/100.0) * frame.height))
            path.addLine(to: CGPoint(x: CGFloat((index * 2)) * width, y: frame.height - (numberOfAccomodation/100.0) * frame.height))
            path.close()
            path.stroke()
            path.fill()
        }
        self.setNeedsDisplay()
    }
}
