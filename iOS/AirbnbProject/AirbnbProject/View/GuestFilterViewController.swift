//
//  GuestFilterViewController.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class GuestFilterViewController: UIViewController {
    @IBOutlet weak var adultCountFilter: GuestFilterReusableView!
    @IBOutlet weak var youthCountFilter: GuestFilterReusableView!
    @IBOutlet weak var infantCountFilter: GuestFilterReusableView!
    
    private var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAddTarget(view: adultCountFilter)
        buttonAddTarget(view: youthCountFilter)
        buttonAddTarget(view: infantCountFilter)
    }
    
    private func buttonAddTarget(view: GuestFilterReusableView) {
        view.minusButton.addTarget(self, action: #selector(self.minusButtonTouchAction), for: .touchUpInside)
        view.plusButton.addTarget(self, action: #selector(self.plusButtonTouchAction), for: .touchUpInside)
    }
    
    @objc private func plusButtonTouchAction(sender: UIButton) {
        guard let view = sender.superview?.superview?.superview as? GuestFilterReusableView else { return }
        let currentCount = Int(view.guestCount.text!)
        view.guestCount.text = String(currentCount! + 1)
        
        totalCount += 1
    }
    
    @objc private func minusButtonTouchAction(sender: UIButton) {
        guard let view = sender.superview?.superview?.superview as? GuestFilterReusableView else { return }
        let currentCount = Int(view.guestCount.text!)
        view.guestCount.text = String(currentCount! - 1)
        
       totalCount -= 1
    }
}
