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
    @IBOutlet weak var starRateAndReviewLabel: UILabel!
    @IBOutlet weak var accomodationTypeAndBedCountLabel: UILabel!
    @IBOutlet weak var superhostLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "AccomodationInfoTableViewCell"
    var models: RoomInfo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pageControl.currentPage = 0
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    private func setupAccomodationView() {
        starRateAndReviewLabel.text = "⭐️ \(models!.scores) (\(models!.reviews))"
        if !models!.is_super_host {
            superhostLabel.isHidden = true
        }
        accomodationTypeAndBedCountLabel.text = "\(models!.room_type) / \(models!.beds) bed"
        titleLabel.text = models?.room_name
    }
    
    private func setupCollectionView() {
        thumbnailImageCollectionView.register(ThumbnailImageCollectionViewCell.nib() , forCellWithReuseIdentifier: ThumbnailImageCollectionViewCell.identifier)
        thumbnailImageCollectionView.dataSource = self
        thumbnailImageCollectionView.delegate = self
        pageControl.hidesForSinglePage = true
    }
    
    func configure(with models: RoomInfo) {
        self.models = models
        setupAccomodationView()
        DispatchQueue.main.async {
            self.thumbnailImageCollectionView.reloadData()
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: FavoriteButton) {
        guard let isFavorite = sender.isFavorite else { return }
        var favoriteStatus = isFavorite
        if favoriteStatus {
            DataUseCase.bookmarkDelete(manager: NetworkManager(), roomid: models!.room_id) { (result) in
                favoriteStatus = !result
                let favoriteButtonManager = FavoriteButtonManager(isFavorite: favoriteStatus)
                self.setFavoriteButtonUI(view: sender, manager: favoriteButtonManager)
            }
        } else {
            DataUseCase.bookmarkAdd(manager: NetworkManager(), roomid: models!.room_id) { (result) in
                favoriteStatus = result
                let favoriteButtonManager = FavoriteButtonManager(isFavorite: favoriteStatus)
                self.setFavoriteButtonUI(view: sender, manager: favoriteButtonManager)
            }
        }
    }
    
    func setFavoriteButtonUI(view: FavoriteButton, manager: FavoriteButtonManager) {
        view.isFavorite = manager.isFavorite
        view.setImage(manager.favoriteButtonImage, for: .normal)
        view.tintColor = manager.favoriteButtonTintColor
    }
}

extension AccomodationInfoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (models?.image_lists.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailImageCollectionViewCell.identifier, for: indexPath) as! ThumbnailImageCollectionViewCell
        let imgUrl: String?
        
        if indexPath.row > (models?.image_lists.count)! - 1 {
            imgUrl = models?.room_thumbnail
        } else {
            imgUrl = models?.image_lists[indexPath.row]
        }
        
        DataUseCase.loadImg(manager: NetworkManager(), imgUrl: imgUrl!) { (image) in
            cell.myImage.image = image ?? UIImage(systemName: "paperplane.fill")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.size.width
        let height = thumbnailImageCollectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.numberOfPages = (self.models?.image_lists.count ?? 0) + 1
        self.pageControl.pageIndicatorTintColor = .darkGray
    }
}

extension AccomodationInfoTableViewCell: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        self.pageControl.currentPage = page
    }
}
