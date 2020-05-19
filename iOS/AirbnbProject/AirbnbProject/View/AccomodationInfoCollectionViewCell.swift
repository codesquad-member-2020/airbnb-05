//
//  AccomodationInfoCollectionViewCell.swift
//  AirbnbProject
//
//  Created by 임승혁 on 2020/05/19.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class AccomodationInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ThumbNailCollectionView: UICollectionView!
    
    static let identifier = "accomodationInfoCollectionViewCell"
    static let nibClassName = "AccomodationInfoCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
