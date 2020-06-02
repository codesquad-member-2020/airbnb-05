//
//  RangeSlider.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/06/02.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {
    
    // 트랙 (가운데 바)
    let trackLayer = RangeSliderTrackLayer()
    
    // 양방향 트랙 조절하는 사이드 버튼
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    var previousLocation = CGPoint()
    // 처음에 프레임이 0,0,0,0 으로 나오는데
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    // 버튼 가로세로 사이즈, height로 줘야 제대로 만들어 지겠지?
    var thumbWidth: CGFloat {
        return CGFloat(frame.height) * 2
    }
    // 최소, 최대 값
    var minimumValue: Double = 0
    var maximumValue: Double = 1_400_000
    
    // 버튼 왼쪽 값, 오른쪽 값
    var lowerValue: Double = 0
    var upperValue: Double = 1_400_000
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        trackLayer.rangeSlider = self
        lowerThumbLayer.rangeSlider = self
        upperThumbLayer.rangeSlider = self
        
        // contentScale 요소를 디바이스의 스크린과 일치 하도록 적용하면
        // retina 디스플레이에서 선명하게 보여지는 것이 보장됨.
        
        trackLayer.contentsScale = UIScreen.main.scale
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        upperThumbLayer.contentsScale = UIScreen.main.scale
        
        // 트랙, 양 사이드 버튼 색깔입혀주기 및 삽입
        layer.addSublayer(trackLayer)
        layer.addSublayer(lowerThumbLayer)
        layer.addSublayer(upperThumbLayer)
        
        updateLayerFrames()
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    func updateLayerFrames() {
        // 트랙 UI 잡아줌
        let trackHeight = bounds.height/5
        trackLayer.frame = CGRect(x: 0, y: bounds.height/2 - trackHeight/2, width: bounds.width, height: trackHeight)
        trackLayer.borderWidth = 0
        trackLayer.backgroundColor = UIColor.blue.cgColor
        //trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height/3)
        trackLayer.setNeedsDisplay()
        
        // 왼쪽 버튼 UI 잡아줌
        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth/2, y: bounds.height/2 - thumbWidth/2,
                                       width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        // 오른쪽 버튼 UI 잡아줌
        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter + thumbWidth/2, y: bounds.height/2 - thumbWidth/2,
                                       width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
    }
    
    // MARK: value를 넣어서 포지션을 잡아줌. 처음 버튼 어딨을지를 잡아준다. (항상 센터를 지향하고 싶으나..)
    func positionForValue(value: Double) -> Double {
        // bounds.width - thumbWidth => 버튼이 끝에 가있는게 아니라 1/2만큼 들어와 있음 그래서 양쪽 합해서 빼주고 사용하는 실제 길이로 만듬
        // value - minimumValue => 비율
        // 분모 : 전체 값의 범위
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue)
    }
    
    // MARK: 버튼 시작 트래킹
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // 터치되고있는 좌표
        previousLocation = touch.location(in: self)
        
        // 좌표를 버튼에서 검색해서 어떤 버튼이 눌려지고 있는가
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        
        // 아니 그럼 어차피 true아닌가?? => beginTracking을 살펴보면 UIControl의 바운드를 터치만해도 동작이 되어지는데
        // 버튼이 아닌곳을 터치했을때도 처리하기 위함.
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    // MARK: 버튼 이동시 트래킹
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // 현재 드래그 되고있는 좌표 - beginTracking에서 가져온 좌표
        let deltaLocation = Double(location.x - previousLocation.x)
        // (( 값 범위 ) * 이동한 길이) / 실제 길이 (전체 길이 - 버튼 사이즈)
        // 값을 변환해줘야함 길이 비율에 맞춰서
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        let thumbWidthDeltaValue = (maximumValue - minimumValue) * Double(thumbWidth) / Double(bounds.width - thumbWidth)
        
        // 현재 로케이션 업데이트
        previousLocation = location
        
        // 어떤 버튼이 활성화 되었는가에 따라 가리키고 있는 값을 업데이트 해줌.
        // 현재 lowerValue, upperValue 업데이트 후
        // boundValue에서 한번 더 처리
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: upperValue - thumbWidthDeltaValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue + thumbWidthDeltaValue, upperValue: maximumValue)
        }
        
        // setDisableActions 애니메이션이 아니라 즉시 적용하도록 변경해줌.
        // 야곰 수업 : begin() ~ commit()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        // 변경된 값에 맞춰서 프레임을 업데이트!
        updateLayerFrames()
        
        CATransaction.commit()
        
        sendActions(for: .valueChanged)
        
        return true
    }
    
    // MARK: 버튼 트래킹 종료시 동작
    // 버튼 트래킹이 종료되면 버튼이 눌리고 있지 않으므로 false로 변경
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
    
}

