//
//  FirstViewController.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/18.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var accomodationCollectionView: UICollectionView!
    
    private let accomodationCollectionViewDataSource = AccomodationCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerAccomodationCollectionViewCell()
    }
    
    private func registerAccomodationCollectionViewCell() {
        let cellNib = UINib(nibName: AccomodationInfoCollectionViewCell.nibClassName, bundle: nil)
        accomodationCollectionView.register(cellNib, forCellWithReuseIdentifier: AccomodationInfoCollectionViewCell.identifier)
        
        accomodationCollectionView.dataSource = accomodationCollectionViewDataSource
    }

}

