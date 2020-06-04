//
//  AccomodationInfoTableViewCell.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/19.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class AccomodationInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var thumbnailImageCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: FavoriteButton!

    static let identifier = "AccomodationInfoTableViewCell"

    var models = [RoomInfo]()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    private func setupCollectionView() {
        thumbnailImageCollectionView.register(ThumbnailImageCollectionViewCell.nib() , forCellWithReuseIdentifier: ThumbnailImageCollectionViewCell.identifier)
        thumbnailImageCollectionView.dataSource = self
        thumbnailImageCollectionView.delegate = self
        pageControl.hidesForSinglePage = true
    }
    
    func configure(with models: [RoomInfo]) {
        self.models = models
        DispatchQueue.main.async {
            self.thumbnailImageCollectionView.reloadData()
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: FavoriteButton) {
        guard let isFavorite = sender.isFavorite else { return }
        let favoriteButtonManager = FavoriteButtonManager(isFavorite: !isFavorite)
        setFavoriteButtonUI(view: sender, manager: favoriteButtonManager)
    }
    
    func setFavoriteButtonUI(view: FavoriteButton, manager: FavoriteButtonManager) {
        view.isFavorite = manager.isFavorite
        view.setImage(manager.favoriteButtonImage, for: .normal)
        view.tintColor = manager.favoriteButtonTintColor
    }
}

extension AccomodationInfoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailImageCollectionViewCell.identifier, for: indexPath) as! ThumbnailImageCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.size.width
        let height = thumbnailImageCollectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.numberOfPages = self.models.count
        self.pageControl.pageIndicatorTintColor = .darkGray
        self.pageControl.currentPage = indexPath.row
    }
}

extension AccomodationInfoTableViewCell: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        self.pageControl.currentPage = page
    }
}
