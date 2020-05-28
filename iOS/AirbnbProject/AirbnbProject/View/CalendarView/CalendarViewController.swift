//
//  CalendarViewController.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/23.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    @IBOutlet weak var headerView: FilterHeaderView!
    @IBOutlet weak var footerView: FilterFooterView!
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    private let numberOfSection = 12
    private let bookingManager = BookingManager()
    private var cellSize: CGFloat?
    private var sectionHeaderHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateFilterTitle()
        setupCollectionView()
        
        footerView.initializationButton.addTarget(self, action: #selector(initializeDate), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
    }
    
    private func setDateFilterTitle() {
        headerView.headerViewTitle.text = "\(bookingManager.getCheckInDay()) - \(bookingManager.getCheckOutDay())"
    }
    
    @objc private func initializeDate() {
        bookingManager.selectedIndexPath.forEach{
            guard let cell = self.calendarCollectionView.cellForItem(at: $0) as? DayCollectionViewCell else {return}
            cell.initializeBackgroundView()
        }
        bookingManager.initializeAll()
        setDateFilterTitle()
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
        
        if indexPath < manager.getYesterdayDatePosition() {
            cell.updateDisabledCell()
        }
        
        if bookingManager.firstSelectedCellIndexPath != nil{
                designateCellBackground(collectionView: collectionView)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: MonthCollectionReusableView.identifier, for: indexPath) as? MonthCollectionReusableView else { return UICollectionReusableView() }
        
        let manager = CalenderCollectionViewManager(section: indexPath.section)
        header.monthYearLabel.text = manager.setSectionHeaderLabel()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if bookingManager.firstSelectedCellIndexPath != nil && bookingManager.secondSelectedCellIndexPath == nil {
            bookingManager.secondSelectedCellIndexPath = indexPath
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell else { return }
        
        if bookingManager.selectedIndexPath.count < 3 {
            // 선택이 되어있는 셀 터치
            if bookingManager.isSelectedCell(indexPath: indexPath, cell: cell) {
                cell.initializeBackgroundView()
            } else {
                // 선택이 안된 셀 터치
                bookingManager.setFisrtSelectedIndexPath(indexPath: indexPath, cell: cell)
                
                bookingManager.isSelectable(indexPath: indexPath)
                
                bookingManager.checkSelectedDatesSameMonth(numberOfItemsInSection: collectionView.numberOfItems(inSection: indexPath.section))
                
                setDateFilterTitle()
            }
        } else { // 3개 이상 터치 되었을 때
            
            for index in bookingManager.selectedIndexPath {
                let cell = collectionView.cellForItem(at: index) as? DayCollectionViewCell
                cell?.initializeBackgroundView()
            }
            bookingManager.initializeAll()
            bookingManager.setFisrtSelectedIndexPath(indexPath: indexPath, cell: cell)
            setDateFilterTitle()
        }
        
        bookingManager.selectedCells[indexPath]?.updateSelectedCellBackgroundView()

        if bookingManager.secondSelectedCellIndexPath != nil {
            designateCellBackground(collectionView: collectionView)
        }
    }
    
    private func designateCellBackground(collectionView: UICollectionView) {
        bookingManager.defineCellType{ indexpath, cellType in
            guard let cell = collectionView.cellForItem(at: indexpath) as? DayCollectionViewCell else { return }
            
            switch cellType {
            case .checkIn:
                cell.updateSelectedCellBackgroundView()
                cell.updateSideEndCellBackgroundView(sideDirection: .left)
            case .checkOut:
                cell.updateSelectedCellBackgroundView()
                cell.updateSideEndCellBackgroundView(sideDirection: .right)
            case .included:
                cell.updatePeriodCellBackgroundView()
            }
        }
    }
}


extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.cellSize = calendarCollectionView.frame.size.width / 7.05
        let sizeForItem = CGSize(width: cellSize!, height: cellSize!)
        return sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        self.sectionHeaderHeight = calendarCollectionView.frame.size.width / 10
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
