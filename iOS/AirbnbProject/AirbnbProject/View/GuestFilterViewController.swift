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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
