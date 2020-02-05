//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    public var dailyWeather: DailyDatum?
    
    public var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        updateUI()
        
    }
    
    func updateUI() {
        guard let weatherCurrent = weather else {
            fatalError("could not get data for weatherCurrent")
        }
        guard let dailyweather = dailyWeather else {
            fatalError("could not get data for dailyweather")
        }
        var timezone = weather?.timezone
        var cityFromLocation = timezone?.split(separator: "/")
        detailView.messageLabel.text = "Weather For \(String(cityFromLocation?.last ?? "")) for \(dailyweather.time)"
        
        detailView.weatherLabel.text = dailyweather.summary
        detailView.wholeWeatherInfoLabel.text = """
        High temperature: \(dailyweather.temperatureHigh)
        Low temperature: \(dailyweather.temperatureLow)
        Sunrise: \(dailyweather.sunriseTime)
        Sunset: \(dailyweather.sunsetTime)
        Windspeed: \(dailyweather.windSpeed)
        Inches of precipitation: \(dailyweather.precipProbability)
"""
        
        
    }

    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(showSettings(_:)))
    }
    
    @objc
    private func showSettings(_ sender: UIBarButtonItem) {
        //print("show settings")
        
        // segue to SettingsVC, basically == prepare for segue
        
        let favoriteVC = FavoriteController()
        //navigationController?.presentedViewController(favoriteVC, animated: true)
        
        navigationController?.pushViewController(favoriteVC, animated: true)
        // if it would be just VC instead of this line we would use PRESENT, instead of push
        // IF WE WANT TO PRESENT IT MODALY USE THIS: present(settingsVC, animated: true)
        // try this - different stype
        //settingsVC.modalPresentationStyle = .overCurrentContext
        //settingsVC.modalTransitionStyle = .flipHorizontal
    }
    

}
