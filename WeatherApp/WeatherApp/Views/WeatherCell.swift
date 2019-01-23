//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
//    public func configureCell(weatherForecast: WeatherDetails? /*, imageIcon: String*/) {
//        
//        if let maxTempC = weatherForecast?.maxTempC {
//            highTemp.text = "High: \(maxTempC) C"
//        }
//        if let minTemp = weatherForecast?.minTempC {
//            lowtemp.text = "Low: \(minTemp) C"
//        }
//        if let dates = weatherForecast?.dateFormattedString {
//            date.text = dates
//        }
//        
//        if let icon = weatherForecast?.icon {
//            weatherIcon.image = UIImage.init(named: icon)
//        }
//        
//        
//    }
}

