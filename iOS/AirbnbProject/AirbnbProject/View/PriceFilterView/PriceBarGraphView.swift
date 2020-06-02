//
//  PriceBarGraphView.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/02.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class PriceBarGraphView: UIView {
    
    var numberOfAccommodationByPriceRange: [CGFloat] = [0, 10,20,30,20,40, 10,20, 10, 10,20,50,20,20,40, 10,20, 10,20,30,0, 10,20,20,40, 10,20, 10,20,50,20,40, 30,70,0]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        let graphWidth: CGFloat = self.frame.width / CGFloat((numberOfAccommodationByPriceRange.count * 2 - 1))
        drawPriceBarGraph(width: graphWidth)
    }
    
    func drawPriceBarGraph(width: CGFloat) {
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
    }
}
