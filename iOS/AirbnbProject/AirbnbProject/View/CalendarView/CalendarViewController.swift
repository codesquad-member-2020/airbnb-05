//
//  CalendarViewController.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/23.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    private let numberOfSection = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
        
        let manager = CalenderCollectionViewManager(indexPath: indexPath)
        let status = manager.setCellHiddenStatus(indexPath: indexPath)
        
        cell.isHidden = status
        cell.dayLabel.text = "\(manager.today)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: MonthCollectionReusableView.identifier, for: indexPath) as? MonthCollectionReusableView else { return UICollectionReusableView() }
        
        header.monthYearLabel.text = "April 2020"
        
        return header
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calendarCollectionView.frame.size.width / 9
        let sizeForItem = CGSize(width: size, height: size)
        return sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerSize = CGSize(width:  calendarCollectionView.frame.size.width, height: calendarCollectionView.frame.size.width / 10)
        return headerSize
    }
}
