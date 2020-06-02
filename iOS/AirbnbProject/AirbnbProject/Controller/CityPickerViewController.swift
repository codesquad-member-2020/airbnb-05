//
//  CityPickerViewController.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/06/01.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class CityPickerViewController: UIViewController {
    
    
    @IBOutlet weak var coloredBackgroundView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var completionButton: UIButton!
    private let defaultMessage = "--- City ---"
    private var cities = ["Asheville", "North Carolina",  "Texas", "Boston", "Massachusetts", "Cambridge", "Massachusetts","Chicago", "Illinois", "New Orleans", "Louisiana", "New York", "Oakland", "California", "Portland", "Oregon", "San Francisco", "Seattle", "Washington"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPickerView()
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setupView() {
        cities.insert(defaultMessage, at: 0)
       completionButton.isUserInteractionEnabled = false
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [ UIColor.airbnbKeyColor!.cgColor, UIColor.airbnbKeyColor!.cgColor, UIColor.coralPink!.cgColor, UIColor.lightPeachPink!.cgColor]
        coloredBackgroundView.layer.addSublayer(gradient)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {

    }
}
extension CityPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
}

extension CityPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        completionButton.setTitle("show 250+ stays in \(cities[row]) 🎉", for: .normal)
        completionButton.backgroundColor = .systemPink
        completionButton.isUserInteractionEnabled = true
    }
}

extension UIColor {
    static let lightPeachPink = UIColor(named: "LightPeachPink")
    static let coralPink = UIColor(named: "CoralPink")
    static let airbnbKeyColor = UIColor(named: "AirbnbKeyColor")
}
