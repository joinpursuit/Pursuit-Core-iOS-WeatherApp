//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Pritesh Nadiadhara on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var detailedWeatherDescription: UITextView!
    @IBOutlet weak var forecast: UILabel!
    @IBOutlet weak var randomCityImage: UIImageView!
    
    public var weatherDataToPass : WeatherDetailData!
    public var sendOverThatCityName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetailViewPage()
        
    }
    
    func setUpDetailViewPage() {
        cityName.text = "Weather for \(sendOverThatCityName ?? "OOOps data is missing")"
        forecast.text = weatherDataToPass.weather
        detailedWeatherDescription.text = " High: \(weatherDataToPass.maxTempF) \n Low: \(weatherDataToPass.minTempF) \n WindSpeed: \(weatherDataToPass.windSpeedMPH)"
        randomCityImage.image = UIImage(named: weatherDataToPass.icon)
        
        
    }
}
