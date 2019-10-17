//
//  WeatherStackView.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherStackView: UIStackView {
    //MARK: - Labels
    var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var highLabel: UILabel = {
        let label = UILabel()
        label.text = "High:"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var lowLabel: UILabel = {
        let label = UILabel()
        label.text = "Low:"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var sunriseLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunrise:"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var sunsetLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunset:"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "WindSpeed:"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var precipitationLabel: UILabel = {
        let label = UILabel()
        label.text = "Inches of Precipitation:"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    func addToStack() {
        self.addArrangedSubview(summaryLabel)
        self.addArrangedSubview(highLabel)
        self.addArrangedSubview(lowLabel)
        self.addArrangedSubview(sunriseLabel)
        self.addArrangedSubview(sunsetLabel)
        self.addArrangedSubview(windSpeedLabel)
        self.addArrangedSubview(precipitationLabel)
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 10
        addToStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
