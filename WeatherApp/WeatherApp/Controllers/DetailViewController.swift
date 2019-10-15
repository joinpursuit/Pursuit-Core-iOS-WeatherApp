//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Properties
    var dailyWeather: DataWrapper?
    var name: String?
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        if let name = self.name, let dailyWeather = self.dailyWeather {
            label.text = "Weather Forcast in \(name) on \(dailyWeather.convertTimeToDate(time: dailyWeather.time))"
        }
        label.textAlignment = .center
        return label
    }()
    var detailStackView = WeatherStackView()
    
    //MARK: - Constraints
    private func setupDetailUI() {
        setupStackView()
        setupWeatherLabel()
    }
    private func setupStackView() {
        view.addSubview(detailStackView)
        NSLayoutConstraint.activate([
            detailStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            detailStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
    }
    private func setupWeatherLabel() {
        view.addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            weatherLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDetailUI()
    }
    

}
