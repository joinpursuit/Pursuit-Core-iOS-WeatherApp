//
//  FavoriteImagesViewController.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteImagesViewController: UIViewController {
    
    @IBOutlet weak var favoriteImagesTableView: UITableView!
    var favoriteImages = [Favorite]() {
        didSet {
            favoriteImagesTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getImages()
        favoriteImagesTableView.dataSource = self
        favoriteImagesTableView.delegate = self
    }
    
    private func getImages() {
        favoriteImages = FavoritesModel.getFavoritedImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getImages()
    }


}

extension FavoriteImagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteImageCell = favoriteImagesTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteImageCell else { fatalError("cannpt find favoritecell")}
        if let image = UIImage(data: favoriteImages[indexPath.row].imageData) {
            favoriteImageCell.favoritedImage.image = image
        }
        return favoriteImageCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        FavoritesModel.deleteFavoriteImage(atIndex: indexPath.row)
        getImages()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
