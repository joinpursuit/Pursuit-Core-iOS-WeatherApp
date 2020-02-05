//
//  DetailView.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit


class DetailView: UIView {
    
    //public var weather = Weather.()
    
    let defaultMessage = """
    Weather Forecast for 
    for
"""
    
    let defaultMessage2 = "Partly Cloudy" // will be changed based on the data from API
    
    let defaultMessage3 = """
High temperature:
Low Temperature:
Sunrise:
Sunset:
Windspeed:
Inches of Precipitation:
"""
//    public lazy var barButtonItem: UIBarButtonItem = {
//        let barButton = UIBarButtonItem()
//        return barButton
//    } ()
    
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.text = defaultMessage
        return label
    }()
    
    public lazy var imageView: UIImageView = {
        let cityImage = UIImageView()
        cityImage.image = UIImage(systemName: "photo")
        return cityImage
    }()
    
    public lazy var weatherLabel: UILabel = {
        let weatherlabel = UILabel()
        weatherlabel.backgroundColor = .systemBackground
        weatherlabel.textAlignment = .center
        weatherlabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        weatherlabel.textColor = .black
        weatherlabel.text = defaultMessage2
        return weatherlabel
    }()
    
    public lazy var wholeWeatherInfoLabel: UILabel = {
        let wholeweatherlabel = UILabel()
        wholeweatherlabel.numberOfLines = 6
        wholeweatherlabel.backgroundColor = .systemBackground
        wholeweatherlabel.textAlignment = .left
        wholeweatherlabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        wholeweatherlabel.textColor = .black
        wholeweatherlabel.text = defaultMessage3
        return wholeweatherlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
       setupMessageLabelConstraints()
       setupimageViewConstraints()
       setupWeatherLabelConstraints()
       setuppWholleWeatherInfoLabelConstraints()
    }
    
    private func setupMessageLabelConstraints() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant:  30),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupimageViewConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupWeatherLabelConstraints() {
        addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant:  20),
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setuppWholleWeatherInfoLabelConstraints() {
        addSubview(wholeWeatherInfoLabel)
        wholeWeatherInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wholeWeatherInfoLabel.topAnchor.constraint(equalTo: weatherLabel.topAnchor, constant:  30),
            wholeWeatherInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wholeWeatherInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
}


