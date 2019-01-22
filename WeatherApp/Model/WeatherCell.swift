//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    var periods: WeatherData!
    override func prepareForReuse() {
        imageViewCell.image = nil
    }
    
}
