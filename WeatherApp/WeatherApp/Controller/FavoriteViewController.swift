//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Biron Su on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteImages = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImages()
        favoriteTableView.dataSource = self
    }
    func updateImages() {
        
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.imageView?.image = UIImage(named: favoriteImages[indexPath.row])
        return cell
    }
    
    
}
