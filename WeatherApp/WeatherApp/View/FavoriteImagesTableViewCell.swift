//
//  FavoriteImagesTableViewCell.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteImagesTableViewCell: UITableViewCell {
    @IBOutlet weak var cityImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
