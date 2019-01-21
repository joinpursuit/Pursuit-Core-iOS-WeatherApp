//
//  FavortiesViewController.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavortiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var favoriteImages = DataPersistanceModel.getImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        

    }
    override func viewDidAppear(_ animated: Bool) {
        favoriteImages = DataPersistanceModel.getImages()
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteImageCell", for: indexPath) as? FavoriteImagesTableViewCell else {return UITableViewCell()}
        let favoriteImageToSet = favoriteImages[indexPath.row]
        if let imageData = UIImage(data: favoriteImageToSet.imageData){
            cell.cityImage.image = imageData
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }

}
