//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Ahad Islam on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    private lazy var tableview: UITableView = {
        let tv = UITableView()
        tv.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "Favorites Cell")
        return tv
    }()
    
    var images = [ImageObject]() {
        didSet {
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    private func loadData() {
        let dataPersistence = DataPersistence<ImageObject>(filename: "favorites.plist")
        do {
            images = try dataPersistence.loadItems().reversed()
        } catch {
            print(error)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemTeal
        setupTableView()
    }
    
    private func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Favorites Cell", for: indexPath) as? FavoritesTableViewCell else {
            print("Error occured making cell.")
            return UITableViewCell()
        }
        cell.configureCell(images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.width
    }
    
}
