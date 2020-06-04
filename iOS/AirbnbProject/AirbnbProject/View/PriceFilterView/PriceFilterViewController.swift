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
    @IBOutlet weak var filterHeaderView: FilterHeaderView!
    @IBOutlet weak var filterFooterView: FilterFooterView!
    
    private var priceBarGraph =  PriceBarGraphView()
    private var rangeMarkingUpperView = UIView()
    private var rangeMarkingLowerView = UIView()
    private var lowerValue: Int = 10_000
    private var upperValue: Int = 1_400_000

    var cityId: Int?
    var guestCount: Int?
    var bookingDate: (String, String)?
    var priceDelegate: SendDataDelegate?
    
    static let segueName = "priceFilterSegue"
    let rangeSlider = RangeSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeMarkingLowerView.backgroundColor = .white
        rangeMarkingUpperView.backgroundColor = .white
        
        priceRangeView.addSubview(priceBarGraph)
        priceRangeView.addSubview(rangeSlider)
        priceRangeView.addSubview(rangeMarkingUpperView)
        priceRangeView.addSubview(rangeMarkingLowerView)
        
        filterFooterView.completeButton.backgroundColor = .systemPink
        filterFooterView.completeButton.isEnabled = true
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
        filterHeaderView.closeButton.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        filterFooterView.completeButton.addTarget(self, action: #selector(fixUpPrice), for: .touchUpInside)
        filterFooterView.initializationButton.addTarget(self, action: #selector(initializer), for: .touchUpInside)
        
        setUpPriceFilterView()
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
        rangeMarkingLowerView.alpha = 0.5
        rangeMarkingUpperView.alpha = 0.5
        
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
    
    @objc private func closeWindow() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func initializer() {
        self.lowerValue = 10000
        self.upperValue = Int(self.rangeSlider.maximumValue)
        self.rangeSlider.lowerValue = self.rangeSlider.minimumValue
        self.rangeSlider.upperValue = self.rangeSlider.maximumValue
        self.rangeSlider.updateLayerFrames()
        rangeMarkingLowerView.alpha = 0
        rangeMarkingUpperView.alpha = 0
        self.priceRangeLabel.text = "₩\(self.lowerValue) - ₩\(self.upperValue)+"
    }
    
    @objc private func fixUpPrice() {
        priceDelegate?.sendPrice?(first: String(lowerValue), second: String(upperValue))
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpPriceFilterView() {
        let paramData = EndPoints.requestPriceList(checkIn: bookingDate?.0, checkOut: bookingDate?.1, guests: guestCount)
        DataUseCase.getPriceList(manager: NetworkManager(), cityId: String(cityId!), paramData: paramData) { (priceInfo) in
            guard let priceInfo = priceInfo else { return }
            self.averagePriceLabel.text = "The average nightly price is ₩\(priceInfo.average)"
            let salePrices = priceInfo.count_list.map {CGFloat($0)}
            self.priceBarGraph.numberOfAccommodationByPriceRange = salePrices
        }
    }
}
