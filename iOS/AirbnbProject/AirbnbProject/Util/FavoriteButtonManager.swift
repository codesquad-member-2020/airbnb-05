//
//  FavoriteButtonManager.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/25.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import Foundation
import UIKit

class FavoriteButtonManager {
    
    var isFavorite: Bool {
        didSet {
            updateisFavorite()
        }
    }
    var favoriteButtonTintColor: UIColor = .lightGray
    var favoriteButtonImage: UIImage = UIImage(systemName: SystemImageName.heartEmpty)!
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
        updateFavoriteButtonColor()
        updateFavoriteButtonImage()
    }
    
    func updateFavoriteButtonColor() {
        switch isFavorite {
        case true:  self.favoriteButtonTintColor = .systemPink
        case false:  self.favoriteButtonTintColor = .lightGray
        }
    }
    
    func updateFavoriteButtonImage() {
        switch isFavorite {
        case true: self.favoriteButtonImage = UIImage(systemName: SystemImageName.heartFill)!
        case false: self.favoriteButtonImage = UIImage(systemName: SystemImageName.heartEmpty)!
        }
    }
    
    func updateisFavorite() {
        isFavorite = !isFavorite
    }
}

enum SystemImageName {
    static let heartFill = "heart.fill"
    static let heartEmpty = "heart"
}
