//
//  FavoritButton.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/21.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    var isFavorite: Bool = false {
        didSet {
            updateFavoriteButton()
        }
    }
    
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
    
    private func updateFavoriteButton() {
        if isFavorite {
            self.tintColor = .systemPink
            self.setImage(UIImage(systemName: SystemImageName.heartFill), for: .normal)
        } else {
            self.tintColor = .lightGray
            self.setImage(UIImage(systemName: SystemImageName.heartEmpty), for: .normal)
        }
    }
}

enum SystemImageName {
    static let heartFill = "heart.fill"
    static let heartEmpty = "heart"
}
