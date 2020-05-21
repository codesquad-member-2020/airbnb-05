//
//  FilterHeaderView.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class FilterHeaderView: UIView {
    @IBOutlet weak var headerViewTitle: UILabel!
    private let nibName = "FilterHeaderView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXIB(nibName: nibName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupXIB(nibName: nibName)
    }
}
