//
//  AccomodationInfoTableViewCell.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/19.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class AccomodationInfoTableViewCell: UITableViewCell {
    
    static let identifier = "AccomodationInfoTableViewCell"
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var thumbnailImageCollectionView: UICollectionView!
    
    var models = [Model]()
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCollectionView() {
        thumbnailImageCollectionView.register(ThumbnailImageCollectionViewCell.nib() , forCellWithReuseIdentifier: ThumbnailImageCollectionViewCell.identifier)
        thumbnailImageCollectionView.dataSource = self
        thumbnailImageCollectionView.delegate = self
        pageControl.hidesForSinglePage = true
    }
    
    func configure(with models: [Model]) {
        self.models = models
        DispatchQueue.main.async {
            self.thumbnailImageCollectionView.reloadData()
        }
    }
}

extension AccomodationInfoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailImageCollectionViewCell.identifier, for: indexPath) as! ThumbnailImageCollectionViewCell
        
        cell.configure(with: models[indexPath.row], indexPath: indexPath)
        
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