//
//  extensionUIView.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupXIB(nibName: String) {
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
}
