//
//  GuestFilterReusableView.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

@IBDesignable
class GuestFilterReusableView: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var guestCount: UILabel!
    
    @IBAction func touchMInusButton(_ sender: Any) {
        NotificationCenter.default.post(name: .minusActive, object: self, userInfo: ["view" : self])
    }
    
    @IBAction func touchPlusButton(_ sender: Any) {
        NotificationCenter.default.post(name: .plusActive, object: self, userInfo: ["view" : self])
    }
    @IBInspectable var titleText: String {
        get {
            return title.text!
        } set {
            title.text = newValue
        }
    }
    
    @IBInspectable var subtitleText: String {
        get {
            return subtitle.text!
        } set {
            subtitle.text = newValue
        }
    }
    private let nibName = "GuestFilterReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXIB(nibName: nibName)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupXIB(nibName: nibName)
    }
}

extension NSNotification.Name {
    static let plusActive = Notification.Name("plusAcitve")
    static let minusActive = Notification.Name("minusAcitve")
}
