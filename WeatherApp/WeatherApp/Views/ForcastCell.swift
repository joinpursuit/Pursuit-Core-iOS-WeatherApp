//
//  ForcastCell.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ForcastCell: UICollectionViewCell {
    var weatherImage = UIImageView()
    var dateLabel = UILabel()
    var highLabel = UILabel()
    var lowLabel = UILabel()
    
    func setupUI() {
        setupDateLabel()
        setUpWeatherImage()
        setupHighLabel()
        setupLowLabel()
    }
    func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        NSLayoutConstraint.activate([dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    func setUpWeatherImage() {
        var frame = weatherImage.frame.size
        frame.height = 100
        frame.width = 100
        weatherImage.frame.size = frame
        weatherImage.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        contentView.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
            weatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    func setupHighLabel() {
        contentView.addSubview(highLabel)
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.textColor = .black
        highLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            highLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 3),
            highLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            highLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    func setupLowLabel() {
        contentView.addSubview(lowLabel)
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.textColor = .black
        lowLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor),
            lowLabel.leadingAnchor.constraint(equalTo: highLabel.leadingAnchor),
            lowLabel.trailingAnchor.constraint(equalTo: highLabel.trailingAnchor),
            lowLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
