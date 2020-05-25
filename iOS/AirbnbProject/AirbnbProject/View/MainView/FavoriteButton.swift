//
//  FavoritButton.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    var isFavorite: Bool? 

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFavoriteButton()
    }
    
    private func setupFavoriteButton() {
        startAnimatingPressActions()
    }
}

