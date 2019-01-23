//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Manny Yusuf on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherHigh: UILabel!
    @IBOutlet weak var weatherLow: UILabel!
    
    public func configureCell(forecast: Weather) {
        weatherDate.text = forecast.dateTimeISO
        weatherImage.image = UIImage.init(named: forecast.iconImage)
        weatherHigh.text = "High is \(forecast.maxTempF.description)°F"
        weatherLow.text = "Low is \(forecast.minTempF.description)°F"
    }
}
