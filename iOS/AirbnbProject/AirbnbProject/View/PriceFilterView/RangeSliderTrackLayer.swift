//
//  RangeSliderTrackLayer.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/06/02.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
        
            // track에 해당하는 베지에 패스 생성
            let basicTrack = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height)
            let path = UIBezierPath(rect: basicTrack)
            ctx.addPath(path.cgPath)
            
            // 기본 색상
            ctx.setFillColor(UIColor.lightGray.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            // 버튼 사이의 색상
            ctx.setFillColor(UIColor.gray.cgColor)
            
            // 위치 잡아주기
            let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
            
            let rect = CGRect(x: lowerValuePosition,
                              y: 0.0,
                              width: upperValuePosition - lowerValuePosition + slider.thumbWidth,
                              height: bounds.height)
            ctx.fill(rect)
        }
    }
}
