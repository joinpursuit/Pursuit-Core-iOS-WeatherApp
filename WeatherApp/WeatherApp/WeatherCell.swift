//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class WeatherCell: UICollectionViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var tempLabel: UILabel!
    
    
    
    public func configureCell( weather: DailyDatum) {
        
        tempLabel.text = weather.temperatureHigh.rounded().description
        
        //dateLabel.text = weather.
        imageView.image = UIImage(named: weather.icon)
        
       let timeInterval: Double = Double(weather.time)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let dateString = dateFormatter.string(from: date)
         
        dateLabel.text = dateString
        
        dateLabel.text = dateFormatter.string(from: date)
 
    }
}
