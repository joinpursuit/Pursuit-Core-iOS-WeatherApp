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
        
//        imageView.getImage(with: weather.currently.icon) {[weak self] (result) in
//            switch result {
//            case .failure:
//                DispatchQueue.main.async {
//                    self?.imageView.image = UIImage(systemName: "excaimationmark.triangle")
//                }
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self?.imageView.image = image
//                }
//            }
//        }

    }
}
