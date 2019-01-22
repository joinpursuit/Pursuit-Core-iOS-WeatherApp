//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Biron Su on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var weatherDetail: WeatherInfo!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLocationDate: UILabel!
    @IBOutlet weak var detailWeatherLocation: UILabel!
    @IBOutlet weak var detailHigh: UILabel!
    @IBOutlet weak var detailLow: UILabel!
    @IBOutlet weak var detailSunrise: UILabel!
    @IBOutlet weak var detailSunset: UILabel!
    @IBOutlet weak var detailWindspeed: UILabel!
    @IBOutlet weak var detailInchesOfSomething: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = UIImage(named: weatherDetail.icon)
//        detailLocationDate.text = "Weather for \() on \()"
        detailWeatherLocation.text = "\(weatherDetail.weather)"
        detailHigh.text = "High: \(weatherDetail.maxTempF)℉"
        detailLow.text = "Low: \(weatherDetail.minTempF)℉"
        detailSunset.text = "Sunset: \(weatherDetail.sunsetISO)"
        detailSunrise.text = "Sunrise: \(weatherDetail.sunriseISO)"
        detailWindspeed.text = "Windspeed: \(weatherDetail.windSpeedMaxMPH) MPH"
        detailInchesOfSomething.text = "Inches of percipitation: \(weatherDetail.precipIN)"
    }
}
