//
//  FavoriteImagesController.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteImagesController: UIViewController {
  

  @IBOutlet weak var favoriteImageTableView: UITableView!
  
  var arrayOfFavoritePhotos = [FavoritePhotos](){
    didSet {
      DispatchQueue.main.async {
        self.favoriteImageTableView.reloadData()
      }
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    favoriteImageTableView.dataSource = self
    favoriteImageTableView.delegate = self
    setPhotosFromModel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setPhotosFromModel()
    favoriteImageTableView.reloadData()
    
  }
  
  func setPhotosFromModel() {
    self.arrayOfFavoritePhotos = FavoriteCityPhotos.getPhotoJournal()
  }
  
}

extension FavoriteImagesController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrayOfFavoritePhotos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = favoriteImageTableView.dequeueReusableCell(withIdentifier: "RandomPictureCell", for: indexPath) as? FavoriteImages else {return UITableViewCell()}
      
      let currentPhoto = arrayOfFavoritePhotos[indexPath.row]
      
      cell.bigPicture.image = UIImage(data: currentPhoto.imageData)
      
      return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 200
    }


}
