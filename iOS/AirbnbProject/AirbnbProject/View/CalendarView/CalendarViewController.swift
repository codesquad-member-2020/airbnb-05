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
    private var secondSelectedCellIndexPath: IndexPath?
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
            cell.updateDisabledCell()
        }
        
        if firstSelectedCellIndexPath != nil, secondSelectedCellIndexPath != nil{
            //                    selectedCells.forEach{ selectedCell in
            //                        selectedCell.value.updateSelectedCellBackgroundView()
            //                    }
            
            self.selectedCellIndexPath = self.selectedCellIndexPath.sorted()
            //        if secondSelectedCellIndexPath != nil {
            for selectedCellIndexPath in selectedCellIndexPath {
                
                let cell = collectionView.cellForItem(at: selectedCellIndexPath) as? DayCollectionViewCell
                
                if selectedCellIndexPath == firstSelectedCellIndexPath {
                    if secondSelectedCellIndexPath != nil {
                        cell?.updateSelectedCellBackgroundView()
                        cell?.updateSideEndCellBackgroundView(sideDirection: .left)
                    }
                }
                
                if selectedCellIndexPath == secondSelectedCellIndexPath {
                    cell?.updateSelectedCellBackgroundView()
                    cell?.updateSideEndCellBackgroundView(sideDirection: .right)
                }
                
                if selectedCellIndexPath != firstSelectedCellIndexPath, selectedCellIndexPath != secondSelectedCellIndexPath{
                    cell?.updatePeriodCellBackgroundView()
                }
            }
            //        }
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: MonthCollectionReusableView.identifier, for: indexPath) as? MonthCollectionReusableView else { return UICollectionReusableView() }
        
        header.monthYearLabel.text = "April 2020"
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if firstSelectedCellIndexPath != nil && secondSelectedCellIndexPath == nil {
            secondSelectedCellIndexPath = indexPath
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell
        
        if selectedCells[indexPath] == cell {
            secondSelectedCellIndexPath = nil
            firstSelectedCellIndexPath = nil
            cell?.initializeBackgroundView()
            selectedCells[indexPath] = nil
            
        } else {
            
            if selectedCellIndexPath.count < 3 {
                
                selectedCells[indexPath] = cell
                selectedCellIndexPath.append(indexPath)
                firstSelectedCellIndexPath = selectedCellIndexPath[0]
                
                guard let firstSelectedCell = firstSelectedCellIndexPath else {return}
                
                if firstSelectedCell > indexPath {
                    selectedCells[firstSelectedCell]?.initializeBackgroundView()
                    self.firstSelectedCellIndexPath = nil
                    secondSelectedCellIndexPath = nil
                    selectedCellIndexPath.remove(at: 0)
                    selectedCells[firstSelectedCell] = nil
                    self.firstSelectedCellIndexPath = indexPath
                    selectedCells[indexPath]?.updateSelectedCellBackgroundView()
                }
                
                if secondSelectedCellIndexPath != nil {
                    guard let secondSelectedCellIndexPath = secondSelectedCellIndexPath else {return}
                    if self.firstSelectedCellIndexPath!.section == secondSelectedCellIndexPath.section {
                        for bookingDateCellIndexPath in self.firstSelectedCellIndexPath!.row ... secondSelectedCellIndexPath.row {
                            selectedCellIndexPath.append(IndexPath(row: bookingDateCellIndexPath, section: self.firstSelectedCellIndexPath!.section))
                        }
                    }
                    else if self.firstSelectedCellIndexPath!.section < secondSelectedCellIndexPath.section {
                        for bookingDateCellIndexPath in self.firstSelectedCellIndexPath!.row ... collectionView.numberOfItems(inSection: self.firstSelectedCellIndexPath!.section) {
                            selectedCellIndexPath.append(IndexPath(row: bookingDateCellIndexPath, section: self.firstSelectedCellIndexPath!.section))
                        }
                        for bookingDateCellIndexPath in 0 ... secondSelectedCellIndexPath.row {
                            selectedCellIndexPath.append(IndexPath(row: bookingDateCellIndexPath, section: secondSelectedCellIndexPath.section))
                        }
                    }
                }
                
            } else {
                firstSelectedCellIndexPath = nil
                secondSelectedCellIndexPath = nil
                selectedCells.forEach{$0.value.initializeBackgroundView()}
                for index in selectedCellIndexPath {
                    let cell = collectionView.cellForItem(at: index) as? DayCollectionViewCell
                    cell?.initializeBackgroundView()
                }
                selectedCells = [:]
                selectedCellIndexPath.removeAll()
                selectedCells[indexPath] = cell
                selectedCellIndexPath.append(indexPath)
                firstSelectedCellIndexPath = indexPath
            }
        }
        
        selectedCells.forEach{ selectedCell in
            selectedCell.value.updateSelectedCellBackgroundView()
        }
        
        self.selectedCellIndexPath = self.selectedCellIndexPath.sorted()
        if secondSelectedCellIndexPath != nil {
            for selectedCellIndexPath in selectedCellIndexPath {
                
                let cell = collectionView.cellForItem(at: selectedCellIndexPath) as? DayCollectionViewCell
                
                if selectedCellIndexPath == firstSelectedCellIndexPath {
                    if secondSelectedCellIndexPath != nil {
                        cell?.updateSideEndCellBackgroundView(sideDirection: .left)
                    }
                }
                
                if selectedCellIndexPath == secondSelectedCellIndexPath {
                    cell?.updateSideEndCellBackgroundView(sideDirection: .right)
                }
                
                if selectedCellIndexPath != firstSelectedCellIndexPath, selectedCellIndexPath != secondSelectedCellIndexPath{
                    cell?.updatePeriodCellBackgroundView()
                }
            }
        }
        
    }
}


extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calendarCollectionView.bounds.width / 7.05
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
