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
        
        if indexPath < manager.getYesterdayDatePosition() {
            cell.updateDisabledCell()
        }
        
        if firstSelectedCellIndexPath != nil, secondSelectedCellIndexPath != nil{
            
            self.selectedCellIndexPath = self.selectedCellIndexPath.sorted()
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
        
        if firstSelectedCellIndexPath != nil && secondSelectedCellIndexPath == nil {
            secondSelectedCellIndexPath = indexPath
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell
        
        if selectedCellIndexPath.count < 3 {
            
            if selectedCells[indexPath] == cell {
                secondSelectedCellIndexPath = nil
                firstSelectedCellIndexPath = nil
                cell?.initializeBackgroundView()
                selectedCells[indexPath] = nil
            } else {
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
