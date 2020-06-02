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
    private var rangeMarkingView = UIView()
    private var lowerValue: Int?
    private var upperValue: Int?
    
    let rangeSlider = RangeSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeMarkingView.backgroundColor = .white
        rangeMarkingView.alpha = 0.5
        
        priceRangeView.addSubview(priceBarGraph)
        priceRangeView.addSubview(rangeSlider)
        priceRangeView.addSubview(rangeMarkingView)
//        priceRangeView.bringSubviewToFront(rangeMarkingView)
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        let sliderWidth = priceRangeView.bounds.width * 0.9
        let sliderHeight = priceRangeView.bounds.height * 0.05
        let graphWidth = priceRangeView.bounds.width * 0.85
        let graphHeight = priceRangeView.bounds.height * 0.4
        
        rangeMarkingView.frame = CGRect(x: 0, y: 0, width: 0, height: graphHeight)
        rangeMarkingView.center = CGPoint(x: priceRangeView.bounds.midX, y: priceRangeView.bounds.midY * 1.4)
        
        rangeSlider.frame = CGRect(x: 0, y: 0,
                                   width: sliderWidth, height: sliderHeight)
        rangeSlider.center = CGPoint(x: priceRangeView.bounds.midX, y: priceRangeView.bounds.maxY * 0.9)
        
        priceBarGraph.frame = CGRect(x: 0, y: 0, width: graphWidth, height: graphHeight)
        priceBarGraph.center = CGPoint(x: priceRangeView.bounds.midX, y: priceRangeView.bounds.midY * 1.4)
    }
    @objc func rangeSliderValueChanged() {
        let lowerValuePosition = CGFloat(rangeSlider.positionForValue(value: rangeSlider.lowerValue))
        let upperValuePosition = CGFloat(rangeSlider.positionForValue(value: rangeSlider.upperValue))
        let width = (upperValuePosition - lowerValuePosition + rangeSlider.thumbWidth)

        DispatchQueue.main.async {
            self.rangeMarkingView.frame = CGRect(x: lowerValuePosition + self.rangeSlider.thumbWidth, y: self.priceBarGraph.frame.origin.y, width: width, height: self.priceBarGraph.frame.height)
        }
    }
}
