//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Matthew Huie on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteImages = DataPersistanceModel.getImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteImages = DataPersistanceModel.getImages()
        favoriteTableView.reloadData()
    }
}
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavImageCell", for: indexPath) as? FavoriteImageTableViewCell else {return UITableViewCell()}
        let favoriteImageToSet = favoriteImages[indexPath.row]
        if let imageData = UIImage(data: favoriteImageToSet.imageData){
            cell.favoriteImages.image = imageData
        }
        return cell
    }
}
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

