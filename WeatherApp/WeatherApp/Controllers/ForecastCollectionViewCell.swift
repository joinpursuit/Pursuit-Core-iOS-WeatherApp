//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ahad Islam on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var highLowLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(forecast: DailyDatum) {
        dateLabel.text = "OK"
        highLowLabel.text = "High: \(forecast.temperatureHigh)℃ \nLow: \(forecast.temperatureLow)℃"
    }
    
    private func setupDateLabel() {
        
    }
}
