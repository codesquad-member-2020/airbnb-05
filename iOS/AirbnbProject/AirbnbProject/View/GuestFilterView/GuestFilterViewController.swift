//
//  GuestFilterViewController.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class GuestFilterViewController: UIViewController {
    
    @IBOutlet weak var filterHeaderView: FilterHeaderView!
    @IBOutlet weak var filterFooterView: FilterFooterView!
    @IBOutlet weak var filterStackView: UIStackView!
     
    static let segueName = "guestFilterSegue"
    
    private var totalCount = 0 {
        didSet {
            completeButtonManage()
        }
    }
    private var filterViewManager: CountButtonManager!
    
    var guestDelegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(plusButtonActive), name: .plusActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(minusButtonActive), name: .minusActive, object: nil)
        
        filterHeaderView.headerViewTitle.text = "Guests"
        filterHeaderView.closeButton.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        filterFooterView.initializationButton.addTarget(self, action: #selector(initializeCount), for: .touchUpInside)
        filterFooterView.completeButton.addTarget(self, action: #selector(fixUpGuestCount), for: .touchUpInside)
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
    
    @objc private func closeWindow() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func initializeCount() {
        filterStackView.subviews.forEach { (view) in
            let filterView = view as? GuestFilterReusableView
            setButtonUI(view: filterView!, manager: CountButtonManager(currentCount: nil, acitve: .initialize))
        }
        totalCount = 0
    }
    
    @objc private func fixUpGuestCount() {
        guestDelegate?.sendData?(data: String(totalCount))
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setButtonUI(view: GuestFilterReusableView, manager: CountButtonManager) {
        view.guestCount.text = String(manager.count)
        
        view.minusButton.tintColor = manager.minusButtonTintColor
        view.plusButton.tintColor = manager.plusButtonTintColor
        view.minusButton.isEnabled = manager.isMinusEnable
        view.plusButton.isEnabled = manager.isPlusEnable
    }
    
    private func completeButtonManage() {
        if totalCount < 1 {
            filterFooterView.completeButton.isEnabled = false
            filterFooterView.completeButton.backgroundColor = .darkGray
        } else {
            filterFooterView.completeButton.isEnabled = true
            filterFooterView.completeButton.backgroundColor = .systemPink
        }
    }
}
