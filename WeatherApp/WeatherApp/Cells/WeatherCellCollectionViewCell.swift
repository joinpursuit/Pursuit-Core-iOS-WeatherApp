//
//  WeatherCellCollectionViewCell.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class WeatherCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var highWeatherLabel: UILabel!

    @IBOutlet weak var lowWeatherLabel: UILabel!
    
//    public func isodateFromString(_ isoDate: String) -> Date? {
//
//          let formatter = DateFormatter()
//          formatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
//          return formatter.date(from: isoDate)
//      }
    
    public func configureCell(weather: DailyDatum) {
       
//       let dateFormatter = DateFormatter()
//        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(weather.time))
//
//        // US English Locale (en_US)
//        dateFormatter.locale = Locale(identifier: "en_US")
//        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd") // set template after setting locale
//        print(dateFormatter.string(from: date))
//
        
        let timeInterval: Double = Double(weather.time)

        let date = Date(timeIntervalSince1970: timeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"

        let dateString = dateFormatter.string(from: date)
        
        dateLabel.text = dateString
        weatherImage.image = UIImage(named: weather.icon)
        highWeatherLabel.text = String("High: \(Int(weather.temperatureHigh)) F")
        lowWeatherLabel.text = String("Low: \(Int(weather.temperatureLow)) F")
    }
}

