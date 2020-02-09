//
//  FavoritePictureCell.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/8/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritePictureCell: UITableViewCell {

    @IBOutlet weak var favoritePicture: UIImageView!
    
    public func configureCell(for favoritePic: Hit) {
        favoritePicture.getImage(with: favoritePic.largeImageURL) {[weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.favoritePicture.image = UIImage(systemName: "exclamationmark")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favoritePicture.image = image
                }
            }
        }
    }
    

}
