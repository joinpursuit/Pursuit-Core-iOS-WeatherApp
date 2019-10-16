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
    lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        if let dailyWeather = self.dailyWeather {
            imageView.image = getImageFrom(forcast: dailyWeather.icon)
        }
        imageView.contentMode = .center
        return imageView
    }()
    var detailStackView = WeatherStackView()
    
    //MARK: - Constraints
    private func setupDetailUI() {
        setupStackView()
        setupWeatherLabel()
        putInfoIntoLabels()
        setupLocationImage()
    }
    private func setupStackView() {
        view.addSubview(detailStackView)
        NSLayoutConstraint.activate([
            detailStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            detailStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
    }
    private func setupWeatherLabel() {
        view.addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            weatherLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        view.layoutIfNeeded()
        weatherLabel.heightAnchor.constraint(equalToConstant: weatherLabel.frame.height).isActive = true
    }
    private func setupLocationImage() {
        view.addSubview(locationImage)
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationImage.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 20),
            locationImage.bottomAnchor.constraint(equalTo: detailStackView.topAnchor, constant: -20),
            locationImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    //MARK: - Functions
    private func putInfoIntoLabels() {
        guard let dailyWeather = dailyWeather else {return}
        detailStackView.summaryLabel.text = dailyWeather.summary
        detailStackView.highLabel.text = "High: \(dailyWeather.temperatureHigh)\u{00B0}F"
        detailStackView.lowLabel.text = "Low: \(dailyWeather.temperatureLow)\u{00B0}F"
        detailStackView.sunriseLabel.text = "Sunrise: \(dailyWeather.convertSunTime(time: dailyWeather.sunriseTime))"
        detailStackView.sunsetLabel.text = "Sunset: \(dailyWeather.convertSunTime(time: dailyWeather.sunsetTime))"
        detailStackView.windSpeedLabel.text = "WindSpeed: \(dailyWeather.windSpeed) MPH"
        detailStackView.precipitationLabel.text = "Inches of Precipitation: \(dailyWeather.precipIntensityMax)"
    }
    private func loadImage() {
        guard let name = name else {return}
        PixabayAPIHelper.manager.getOnePictureUrl(nameOfPlace: name) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let urlString):
                ImageHelper.shared.fetchImage(urlString: urlString) { (resultFromImageHelper) in
                    switch resultFromImageHelper {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.locationImage.contentMode = .scaleToFill
                            self.locationImage.image = image
                        }
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDetailUI()
        loadImage()
    }
    

}
