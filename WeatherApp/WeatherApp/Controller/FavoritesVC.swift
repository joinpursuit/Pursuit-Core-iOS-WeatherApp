//
//  FavoritesVC.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    var favoriteImages = PersistenceModel.getFav()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteImages = PersistenceModel.getFav()
        myTableView.reloadData()
    }
    


}
extension FavoritesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {return UITableViewCell()}
        let imageToSet = favoriteImages[indexPath.row]
        if let imageData = UIImage(data: imageToSet.imageData){
            cell.photo.image = imageData
        }
        return cell
    }
}

