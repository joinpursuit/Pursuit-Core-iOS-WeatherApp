//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {

    public lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sunrise")
        return image
    }()
    
    public lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemYellow
        label.numberOfLines = 0
        return label
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
      setUpImageConstraints()
        setUpLabelConstraints()
     }
    
    private func setUpImageConstraints() {
        addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weatherImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            weatherImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.40)
        ])
    }
    
    private func setUpLabelConstraints() {
        addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 40),
            weatherLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            weatherLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40)
        ])
    }
}
