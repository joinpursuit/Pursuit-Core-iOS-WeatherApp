//
//  WeatherCollectionCell.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherCollectionCell: UICollectionViewCell {
  
  @IBOutlet weak var date: UILabel!
  
  @IBOutlet weak var weatherIcon: UIImageView!
  
  @IBOutlet weak var highTemp: UILabel!
  
  @IBOutlet weak var lowtemp: UILabel!
  
  
  public func configureCell(weatherForecast: WeatherDetails? /*, imageIcon: String*/) {
    
    if let maxTempC = weatherForecast?.maxTempC {
      highTemp.text = "High: \(maxTempC) °C"
    }
    if let minTemp = weatherForecast?.minTempC {
      lowtemp.text = "Low: \(minTemp) °C"
    }
    if let dates = weatherForecast?.dateFormattedString {
      date.text = dates
    }
    
    if let icon = weatherForecast?.icon {
     weatherIcon.image = UIImage.init(named: icon)
    }
    
    
  }
  
}
