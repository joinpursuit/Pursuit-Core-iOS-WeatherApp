//
//  FavoritesImagesViewController.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesImagesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var addFavoritesImages = WeatherModel.getImage()
    
    var favirite = [CityImages.HitWrapper]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
}
extension FavoritesImagesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return addFavoritesImages.count
        return savedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as? FavoritesImagesTableViewCell else {
            return UITableViewCell()
        }
        favoriteCell.imageCell.image = savedImages[indexPath.row]
        return favoriteCell
    }
}
extension FavoritesImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
