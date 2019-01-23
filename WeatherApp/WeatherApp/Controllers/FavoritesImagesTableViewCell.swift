//
//  FavoritesImagesTableViewCell.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesImagesTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    var setImage: WeatherData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
