//
//  FavoritePhotosCell.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritePhotosCell: UITableViewCell {
    
    @IBOutlet weak var favoritePhotosImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
