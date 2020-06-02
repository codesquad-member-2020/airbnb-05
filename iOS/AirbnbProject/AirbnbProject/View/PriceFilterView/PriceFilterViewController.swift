//
//  PriceFilterViewController.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/06/02.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class PriceFilterViewController: UIViewController {
    
    @IBOutlet weak var priceRangeView: UIView!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    
    private var priceBarGraph =  PriceBarGraphView()
    private var rangeMarkingUpperView = UIView()
    private var rangeMarkingLowerView = UIView()
    private var lowerValue: Int = 10_000
    private var upperValue: Int = 1_400_000
    
    let rangeSlider = RangeSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeMarkingLowerView.backgroundColor = .white
        rangeMarkingLowerView.alpha = 0.5
        rangeMarkingUpperView.backgroundColor = .white
        rangeMarkingUpperView.alpha = 0.5
        
        priceRangeView.addSubview(priceBarGraph)
        priceRangeView.addSubview(rangeSlider)
        priceRangeView.addSubview(rangeMarkingUpperView)
        priceRangeView.addSubview(rangeMarkingLowerView)
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        let sliderWidth = priceRangeView.bounds.width * 0.9
        let sliderHeight = priceRangeView.bounds.height * 0.05
        let graphWidth = priceRangeView.bounds.width * 0.85
        let graphHeight = priceRangeView.bounds.height * 0.4
        
        rangeSlider.frame = CGRect(x: 0, y: 0,
                                   width: sliderWidth, height: sliderHeight)
        rangeSlider.center = CGPoint(x: priceRangeView.bounds.midX, y: priceRangeView.bounds.maxY * 0.9)
        
        priceBarGraph.frame = CGRect(x: 0, y: 0, width: graphWidth, height: graphHeight)
        priceBarGraph.center = CGPoint(x: priceRangeView.bounds.midX, y: priceRangeView.bounds.midY * 1.4)
    }
    
    @objc func rangeSliderValueChanged() {
        let maximumValuePosition = CGFloat(rangeSlider.positionForValue(value: rangeSlider.maximumValue))
        let lowerValuePosition = CGFloat(rangeSlider.positionForValue(value: rangeSlider.lowerValue))
        let upperValuePosition = CGFloat(rangeSlider.positionForValue(value: rangeSlider.upperValue))
        
        self.lowerValue = Int(self.rangeSlider.lowerValue) - Int(self.rangeSlider.thumbWidthDeltaValue)
        self.upperValue = Int(self.rangeSlider.upperValue) + Int(self.rangeSlider.thumbWidthDeltaValue)
        
        if lowerValue <= 10_000 {
            self.lowerValue = 10000
        }
        
        if upperValue >= 1_400_000 {
            self.upperValue = 1_400_000
        }
        
        self.priceRangeLabel.text = "₩\(self.lowerValue) - ₩\(self.upperValue)+"
        
        self.rangeMarkingLowerView.frame = CGRect(x: self.priceBarGraph.frame.origin.x, y: self.priceBarGraph.frame.origin.y, width: lowerValuePosition - self.rangeSlider.thumbWidth/4, height: self.priceBarGraph.frame.height)
        
        self.rangeMarkingUpperView.frame = CGRect(x: upperValuePosition + self.rangeSlider.thumbWidth*1.75, y: self.priceBarGraph.frame.origin.y, width: maximumValuePosition - upperValuePosition, height: self.priceBarGraph.frame.height)
    }
}
