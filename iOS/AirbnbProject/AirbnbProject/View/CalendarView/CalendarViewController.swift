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
    private var firstSelectedCellIndexPath: IndexPath?
    private var selectedCells = [ IndexPath : DayCollectionViewCell ]()
    private var selectedCellIndexPath = [IndexPath]()
    private var selectedDates = [BookingDate]()
    
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
        
        if indexPath < manager.getYesterdayDatePosition() {
            cell.dayLabel.textColor = .lightGray
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: MonthCollectionReusableView.identifier, for: indexPath) as? MonthCollectionReusableView else { return UICollectionReusableView() }
        
        header.monthYearLabel.text = "April 2020"
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell
        
        if selectedCells[indexPath] == collectionView.cellForItem(at: indexPath){
            selectedCells[indexPath]!.initializeBackgroundView()
            selectedCellIndexPath.removeAll()
            selectedCells[indexPath] = nil
        } else {
            
            if selectedCells.count < 2 {
                
                selectedCellIndexPath.append(indexPath)
                selectedCells[indexPath] = cell
                firstSelectedCellIndexPath = selectedCellIndexPath[0]
                guard let firstSelectedCellIndexPath = firstSelectedCellIndexPath else {return}
                
                if firstSelectedCellIndexPath > indexPath {
                    selectedCellIndexPath.remove(at: 0)
                    selectedCells[firstSelectedCellIndexPath] = nil
                }
                
            } else {
                firstSelectedCellIndexPath = nil
                selectedCells.forEach{$0.value.initializeBackgroundView()}
                selectedCells = [:]
                selectedCellIndexPath.removeAll()
                selectedCellIndexPath.append(indexPath)
            }
        }
        selectedCells.forEach{ selectedCell in
            selectedCell.value.updateSelectedCellBackgroundView()
        }
    }
}


extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calendarCollectionView.bounds.width / 7.25
        let sizeForItem = CGSize(width: size, height: size)
        return sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerSize = CGSize(width:  calendarCollectionView.frame.size.width, height: calendarCollectionView.frame.size.width / 10)
        return headerSize
    }
}

struct BookingDate {
    let checkInyear : String
    let checkInmonth : String
    let checkIndate : String
    let checkOutyear : String
    let checkOutmonth : String
    let checkOutdate : String
}
