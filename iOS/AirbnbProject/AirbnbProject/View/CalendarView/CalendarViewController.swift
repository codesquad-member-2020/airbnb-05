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
    private var cellSize: CGFloat?
    private var sectionHeaderHeight: CGFloat?
    
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
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
        
        let manager = CalenderCollectionViewManager(section: indexPath.section)
        let status = manager.setCellHiddenStatus(row: indexPath.row)
        
        cell.isHidden = status
        cell.dayLabel.text = "\(manager.setCellday(row: indexPath.row))"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: MonthCollectionReusableView.identifier, for: indexPath) as? MonthCollectionReusableView else { return UICollectionReusableView() }
        
        let manager = CalenderCollectionViewManager(section: indexPath.section)
        header.monthYearLabel.text = manager.setSectionHeaderLabel()
        
        return header
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //self.cellSize = calendarCollectionView.frame.size.width / 7.05
        let sizeForItem = CGSize(width: cellSize!, height: cellSize!)
        return sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //self.sectionHeaderHeight = calendarCollectionView.frame.size.width / 10
        let headerSize = CGSize(width:  calendarCollectionView.frame.size.width, height: sectionHeaderHeight!)
        return headerSize
    }
}

extension CalendarViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let sectionHeight = cellSize! * 6 + sectionHeaderHeight!
        
        var offset = targetContentOffset.pointee
        let index = (offset.y + scrollView.contentInset.bottom) / sectionHeight
        let roundedIndex = round(index)
        
        offset = CGPoint(x: scrollView.contentInset.top, y: roundedIndex * sectionHeight)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                scrollView.setContentOffset(offset, animated: false)
            }, completion: nil)
        }
    }
}
