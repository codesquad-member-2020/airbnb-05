//
//  FilterFooterView.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class FilterFooterView: UIView {
    
    @IBOutlet weak var initializationButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    private let nibName = "FilterFooterView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXIB(nibName: nibName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupXIB(nibName: nibName)
    }
}
