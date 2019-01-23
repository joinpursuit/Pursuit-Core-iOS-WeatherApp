//
//  FavoriteWeatherPicturesViewController.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteWeatherPicturesViewController: UIViewController {
    @IBOutlet weak var savedPhotosTableView: UITableView!
    
    var favoritedImages =  SavedImageModel.getSavedImages(){
        didSet {
            savedPhotosTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
        savedPhotosTableView.delegate = self
        savedPhotosTableView.dataSource = self
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    func loadFavorites() {
        favoritedImages = SavedImageModel.getSavedImages()
    }


}

extension FavoriteWeatherPicturesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        
        return favoritedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = savedPhotosTableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? SavedPicturesTableViewCell else {return UITableViewCell()}
  let image = favoritedImages[indexPath.row]
        
        ImageHelper.shared.fetchImage(urlString: image.imageURL) { (error, data) in
            if let error = error {
                print("Error: \(error)")
            } else if let image = data {
        cell.savedPictureView.image = image
            }
        }
       
        
        return cell
    }
    
    
}
