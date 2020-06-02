//
//  RangeSliderThumbLayer.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/06/02.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class RangeSliderThumbLayer: CALayer {
    // 선택되어져서 움직이고 있나 없나를 나타낸다.
    var highlighted: Bool = false {
        didSet {
            //버튼 속성이 변경될때마다 다시 그려줌.
            setNeedsDisplay()
        }
    }
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let path = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: slider.thumbWidth, height: slider.thumbWidth)
            
            let cornerRadius = path.height / 2.0
            let thumbPath = UIBezierPath(roundedRect: path, cornerRadius: cornerRadius)
            
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
            
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.setLineWidth(1)
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()
        }
    }
}
