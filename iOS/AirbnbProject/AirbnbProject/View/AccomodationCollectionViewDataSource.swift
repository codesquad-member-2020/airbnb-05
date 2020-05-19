//
//  AccomodationCollectionViewDataSource.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/19.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class AccomodationCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccomodationInfoCollectionViewCell.identifier, for: indexPath) as? AccomodationInfoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .brown
        
        return cell
    }
    

}
