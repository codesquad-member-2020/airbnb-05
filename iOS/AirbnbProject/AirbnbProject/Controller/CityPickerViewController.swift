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
    
    private let defaultMessage = CityInfo(city_id: -1, city_name: "--- City ---")
    private var selectedCityId: Int?
    private var cities: [CityInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCityList()
        setupView()
        setupPickerView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainTabView = segue.destination as? UITabBarController else { return }
        guard let mainListView = mainTabView.viewControllers?.first as? MainViewController else { return }
        
        mainListView.selectedCityId = selectedCityId
    }
    
    private func configureCityList() {
        DataUseCase.getCityList(manager: NetworkManager()) { (cityList) in
            self.cities = cityList
            self.cities?.insert(self.defaultMessage, at: 0)
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setupView() {
        completionButton.isUserInteractionEnabled = false
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [ UIColor.airbnbKeyColor!.cgColor, UIColor.airbnbKeyColor!.cgColor, UIColor.coralPink!.cgColor, UIColor.lightPeachPink!.cgColor]
        coloredBackgroundView.layer.addSublayer(gradient)
    }
}
extension CityPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities?.count ?? 0
    }
}

extension CityPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities![row].city_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let cityList = cities else { return }
        
        if cityList[row].city_name == defaultMessage.city_name {
            completionButton.setTitle("Pick A City", for: .normal)
            completionButton.backgroundColor = .darkGray
            completionButton.isUserInteractionEnabled = false
        } else {
            self.selectedCityId = cityList[row].city_id
            completionButton.setTitle("show 250+ stays in \(cities![row].city_name) 🎉", for: .normal)
            completionButton.backgroundColor = .systemPink
            completionButton.isUserInteractionEnabled = true
        }
    }
}

extension Notification.Name {
    static let cityIdFromCityViewController = Notification.Name(rawValue: "cityIdFromCityViewController")
}

extension UIColor {
    static let lightPeachPink = UIColor(named: "LightPeachPink")
    static let coralPink = UIColor(named: "CoralPink")
    static let airbnbKeyColor = UIColor(named: "AirbnbKeyColor")
}

enum UserInfoKey {
    static let cityId = "cityId"
}
