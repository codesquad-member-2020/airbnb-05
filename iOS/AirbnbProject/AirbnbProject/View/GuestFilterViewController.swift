//
//  GuestFilterViewController.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class GuestFilterViewController: UIViewController {
    private var totalCount = 1
    private var filterViewManager: CountButtonManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(plusButtonActive), name: .plusActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(minusButtonActive), name: .minusActive, object: nil)
    }
    
    @objc private func plusButtonActive(notification: Notification) {
        guard let postView = notification.userInfo?["view"] as? GuestFilterReusableView else { return }
        filterViewManager = CountButtonManager(currentCount: postView.guestCount.text!, acitve: .plus)
        
        setButtonUI(view: postView, manager: filterViewManager)
        totalCount += 1
    }
    
    @objc private func minusButtonActive(notification: Notification) {
        guard let postView = notification.userInfo?["view"] as? GuestFilterReusableView else { return }
        filterViewManager = CountButtonManager(currentCount: postView.guestCount.text!, acitve: .minus)
        
        setButtonUI(view: postView, manager: filterViewManager)
        totalCount -= 1
    }
    
    private func setButtonUI(view: GuestFilterReusableView, manager: CountButtonManager) {
        view.guestCount.text = String(manager.count)
        
        view.minusButton.tintColor = manager.minusButtonTintColor
        view.plusButton.tintColor = manager.plusButtonTintColor
        view.minusButton.isEnabled = manager.isMinusEnable
        view.plusButton.isEnabled = manager.isPlusEnable
    }
}
