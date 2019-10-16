//
//  FavViewController.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {
    var favs = [Data]() {
        didSet{
            favTableView.reloadData()
        }
    }
    
    lazy var favTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(FavTableViewCell.self, forCellReuseIdentifier: "favCell")
        tableView.frame = self.view.bounds
        tableView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private func setupFavUI() {
        setupTableView()
    }
    private func setupTableView() {
        view.addSubview(favTableView)
        favTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    private func getFavs() {
        do {
            let savedFavs = try SavedPicPersistance.manager.getPictures()
            favs = savedFavs
        } catch {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupFavUI()
        getFavs()
    }

}

extension FavViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as? FavTableViewCell else {
            return UITableViewCell()
        }
        let reversedFavs = favs.reversed()
        let fav = Array(reversedFavs)[indexPath.row]
        if let image = UIImage(data: fav) {
            cell.favImage.image = image
        }
        return cell
    }
    
    
}
