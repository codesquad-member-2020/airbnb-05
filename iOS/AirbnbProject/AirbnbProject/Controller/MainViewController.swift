//
//  FirstViewController.swift
//  AirbnbProject
//
//  Created by Keunna Lee on 2020/05/18.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var infoTableView: UITableView!
    private let tableViewHeight = CGFloat(250)
    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        models.append(Model(imageName: "bye"))
        models.append(Model(imageName: "bye"))
        models.append(Model(imageName: "bye"))
        models.append(Model(imageName: "bye"))
        infoTableView.delaysContentTouches = false
    }
    
    private func setupTableView() {
        infoTableView.register(AccomodationInfoTableViewCell.nib(), forCellReuseIdentifier: AccomodationInfoTableViewCell.identifier)
        infoTableView.dataSource = self
        infoTableView.delegate = self
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTableView.dequeueReusableCell(withIdentifier: AccomodationInfoTableViewCell.identifier, for: indexPath) as! AccomodationInfoTableViewCell
        cell.configure(with: models)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewHeight
    }
}


