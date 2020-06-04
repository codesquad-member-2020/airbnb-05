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
    
    static let segueName = "dateFilterSegue"
    
    private let numberOfSection = 12
    private let bookingManager = BookingManager()
    private let cellManager = CalendarCollectionViewCellManager()
    private var cellSize: CGFloat?
    private var sectionHeaderHeight: CGFloat?
    var dateDelegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateFilterTitle()
        setupCollectionView()
        
        headerView.closeButton.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        footerView.initializationButton.addTarget(self, action: #selector(initializeDate), for: .touchUpInside)
        footerView.completeButton.addTarget(self, action: #selector(fixUpDate), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(completeButtonManage),
                                               name: .selectedCheckoutDate,
                                               object: nil)
    }
    
    private func setupCollectionView() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
    }
    
    private func setDateFilterTitle() {
        let checkInMonth = getMonthStringThroughManager(indexPath: bookingManager.firstSelectedCellIndexPath)
        let checkOutMonth = getMonthStringThroughManager(indexPath: bookingManager.secondSelectedCellIndexPath)
        let checkInDay = bookingManager.getCheckInDay()
        let checkOutDay = bookingManager.getCheckOutDay()
        headerView.headerViewTitle.text = "\(checkInDay) \(checkInMonth) - \(checkOutDay) \(checkOutMonth)"
    }
    
    private func getMonthStringThroughManager(indexPath: IndexPath?) -> String {
        guard let unwrapIndexPath = indexPath else { return "" }
        
        let manager = CalenderCollectionViewManager(section: unwrapIndexPath.section)
        return manager.getMonthAsString()
    }
    
    private func getMonthThroughManager(indexPath: IndexPath?) -> String {
        guard let unwrapIndexPath = indexPath else { return "" }
        
        let manager = CalenderCollectionViewManager(section: unwrapIndexPath.section)
        return manager.getMonth()
    }
    
    private func getYearStringThroughManager(indexPath: IndexPath?) -> String {
        guard let unwrapIndexPath = indexPath else { return "" }
        
        let manager = CalenderCollectionViewManager(section: unwrapIndexPath.section)
        return manager.getYearAsString()
    }
    
    private func bookingDate() -> (String,String) {
        let checkInYear = getYearStringThroughManager(indexPath: bookingManager.firstSelectedCellIndexPath)
        let checkOutYear = getYearStringThroughManager(indexPath: bookingManager.secondSelectedCellIndexPath)
        let checkInMonth = getMonthThroughManager(indexPath: bookingManager.firstSelectedCellIndexPath)
        let checkOutMonth = getMonthThroughManager(indexPath: bookingManager.secondSelectedCellIndexPath)
        let checkInDay = bookingManager.getCheckInDay()
        let checkOutDay = bookingManager.getCheckOutDay()
        
        let checkInDate = "\(checkInYear)-\(checkInMonth)-\(checkInDay)"
        let checkOutDate = "\(checkOutYear)-\(checkOutMonth)-\(checkOutDay)"
        
        return (checkInDate, checkOutDate)
    }
    
    @objc private func closeWindow() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func initializeDate() {
        bookingManager.selectedIndexPath.forEach{
            guard let cell = self.calendarCollectionView.cellForItem(at: $0) as? DayCollectionViewCell else {return}
            cell.initializeBackgroundView()
        }
        bookingManager.initializeAll()
        setDateFilterTitle()
    }
    
    @objc private func fixUpDate() {
        dateDelegate?.sendDate?(first: bookingDate().0, second: bookingDate().1)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func completeButtonManage() {
        if bookingManager.isSelectedAllDate() {
            footerView.completeButton.isEnabled = true
            footerView.completeButton.backgroundColor = .systemPink
        } else {
            footerView.completeButton.isEnabled = false
            footerView.completeButton.backgroundColor = .darkGray
        }
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
            cell.viewConfiguration = cellManager.fetchMarkedCellViewConfiguration(cellType: .userInteractionUnabled)
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell else { return }
        
        bookingManager.setSecondSelectedIndexPath(indexPath: indexPath)
        
        if bookingManager.selectedIndexPath.count < 3 {
            if bookingManager.isSelectedCell(indexPath: indexPath, cell: cell) {
                cell.viewConfiguration = cellManager.fetchMarkedCellViewConfiguration(cellType: .deselected)
            } else {
                bookingManager.setFirstSelectedIndexPath(indexPath: indexPath, cell: cell)
                bookingManager.isSelectable(indexPath: indexPath)
                cell.viewConfiguration = cellManager.fetchMarkedCellViewConfiguration(cellType: .selected)
                bookingManager.checkSelectedDatesSameMonth(numberOfItemsInSection: collectionView.numberOfItems(inSection: indexPath.section))
                setDateFilterTitle()
            }
        } else {
            for index in bookingManager.selectedIndexPath {
                guard let cell = collectionView.cellForItem(at: index) as? DayCollectionViewCell else {return}
                cell.viewConfiguration = cellManager.fetchMarkedCellViewConfiguration(cellType: .deselected)
            }
            bookingManager.initializeAll()
            bookingManager.setFirstSelectedIndexPath(indexPath: indexPath, cell: cell)
            setDateFilterTitle()
        }
        let selectedCell =  bookingManager.selectedCells[indexPath]
        selectedCell?.viewConfiguration = cellManager.fetchMarkedCellViewConfiguration(cellType: .selected)
        if bookingManager.secondSelectedCellIndexPath != nil {
            designateCellBackground(collectionView: collectionView)
        }
    }
    
    private func designateCellBackground(collectionView: UICollectionView) {
        bookingManager.defineCellType{ indexpath, cellType in
            guard let cell = collectionView.cellForItem(at: indexpath) as? DayCollectionViewCell else { return }
            cell.viewConfiguration = cellManager.fetchMarkedCellViewConfiguration(cellType: cellType)
        }
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.cellSize = calendarCollectionView.frame.size.width / 7
        let sizeForItem = CGSize(width: cellSize!, height: cellSize!)
        return sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        self.sectionHeaderHeight = calendarCollectionView.frame.size.width / 10
        let headerSize = CGSize(width:  calendarCollectionView.frame.size.width, height: sectionHeaderHeight!)
        return headerSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
