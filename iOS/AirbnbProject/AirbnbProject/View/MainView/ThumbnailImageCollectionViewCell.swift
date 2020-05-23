//
//  ThumbnailImageCollectionViewCell.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/19.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class ThumbnailImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myImage: UIImageView!
    
    static let identifier = "ThumbnailImageCollectionViewCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public func configure(with model: Model) {
        self.myImage.image = #imageLiteral(resourceName: "welcom_DD")
    }
}
