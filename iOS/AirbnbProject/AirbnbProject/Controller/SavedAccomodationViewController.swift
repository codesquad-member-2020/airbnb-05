//
//  SecondViewController.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/18.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class SavedAccomodationViewController: UIViewController {
    
    @IBOutlet weak var savedAccomodationTableView: UITableView!

    var savedAccomodations = [Model]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        savedAccomodations.append(Model(imageName: "bye", isFavorite: true))
        savedAccomodations.append(Model(imageName: "bye", isFavorite: false))
        savedAccomodations.append(Model(imageName: "bye", isFavorite: true))
        savedAccomodations.append(Model(imageName: "bye", isFavorite: false))
    }

    private func setupTableView() {
        savedAccomodationTableView.register(AccomodationInfoTableViewCell.nib(), forCellReuseIdentifier: AccomodationInfoTableViewCell.identifier)
        savedAccomodationTableView.dataSource = self
        savedAccomodationTableView.delegate = self
        savedAccomodationTableView.delaysContentTouches = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(savedAccomodationCellTapped))
        self.savedAccomodationTableView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func savedAccomodationCellTapped(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.savedAccomodationTableView)
        guard let tappedCellIndexPath = self.savedAccomodationTableView.indexPathForRow(at: tapLocation) else {return}
        let tappedCell = self.savedAccomodationTableView.cellForRow(at: tappedCellIndexPath) as! AccomodationInfoTableViewCell
    }

}
extension SavedAccomodationViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return savedAccomodations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedAccomodationTableView.dequeueReusableCell(withIdentifier: AccomodationInfoTableViewCell.identifier, for: indexPath) as! AccomodationInfoTableViewCell
        cell.configure(with: savedAccomodations)
        
        cell.favoriteButton.isFavorite = savedAccomodations[indexPath.row].isFavorite
        let favoriteButtonManager = FavoriteButtonManager(isFavorite: cell.favoriteButton.isFavorite!)
        cell.setFavoriteButtonUI(view: cell.favoriteButton, manager: favoriteButtonManager)
        
        return cell

    }
}

extension SavedAccomodationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 2.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width / 10
    }
}
