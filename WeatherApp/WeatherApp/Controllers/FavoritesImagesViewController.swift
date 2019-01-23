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
    //var favirite = [CityImages.HitWrapper]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        addFavoritesImages = WeatherModel.getImage()
        tableView.reloadData()
    }
}
extension FavoritesImagesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addFavoritesImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as? FavoritesImagesTableViewCell else {
            return UITableViewCell()
        }
        let imageToSet = addFavoritesImages[indexPath.row]
        if let imageData = UIImage(data: imageToSet.imageData){
            favoriteCell.imageCell.image = imageData
            favoriteCell.layer.cornerRadius = 30
            favoriteCell.layer.masksToBounds = true
        }
        return favoriteCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
