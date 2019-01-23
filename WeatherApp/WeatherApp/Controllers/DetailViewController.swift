//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Matthew Huie on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailCityImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var detailHighTemp: UILabel!
    @IBOutlet weak var detailLowTemp: UILabel!
    @IBOutlet weak var detailSunrise: UILabel!
    @IBOutlet weak var detailSunset: UILabel!
    @IBOutlet weak var detailWindspeed: UILabel!
    @IBOutlet weak var detailPercipitation: UILabel!
    
    var detailForcast: ForcastData?
    var detailLocation = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let detailInfo = detailForcast {
            detailHighTemp.text = "High: \(detailInfo.maxTempF)°F"
            detailLowTemp.text = "Low: \(detailInfo.minTempF)°F"
            detailSunset.text = "Sunset: \(WeatherDateHelper.formatISOToTime(dateString: detailInfo.sunsetISO))"
            detailSunrise.text = "Sunrise: \(WeatherDateHelper.formatISOToDate(dateString: detailInfo.sunriseISO))"
            detailWindspeed.text = "Windspeed: \(detailInfo.windSpeed80mMPH)"
            detailPercipitation.text = "Precipitation in Inches: \(detailInfo.precipIN)"
            weatherLabel.text = detailInfo.weather
            detailTitle.text = "Weather Forcast for \(detailLocation) for \(WeatherDateHelper.formatISOToDate(dateString: detailInfo.dateTimeISO))"
            
        }
    }
    
    
   
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
    }
    
}
