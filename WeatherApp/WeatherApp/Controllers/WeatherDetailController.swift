//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailController: UIViewController {
    public var dayForecast: Periods!
    
    var forecastDetails: Periods?
    @IBOutlet weak var forecastAndDate: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let forecastDetails = dayForecast else {return}
//        if let forecastDetails = forecastDetails {
        forecastAndDate.text = "Weather is ()"
            longDescription.text = dayForecast.weather.description
            print(dayForecast.weather.description)
            highTemp.text = dayForecast.maxTempF.description
            lowTemp.text = dayForecast.minTempF.description
            sunrise.text = dayForecast.sunriseISO.description
            sunset.text = dayForecast.sunsetISO.description
            windSpeed.text = dayForecast.windSpeedMPH.description
            precipitation.text = dayForecast.precipIN.description
//            longDescription.text = forecastDetails.weather.description
//            highTemp.text = forecastDetails.maxTempF.description
//            lowTemp.text = forecastDetails.minTempF.description
//            sunrise.text = forecastDetails.sunriseISO.description
//            sunset.text = forecastDetails.sunsetISO.description
//            windSpeed.text = forecastDetails.windSpeedMPH.description
//            precipitation.text = forecastDetails.precipIN.description
            
//        }
        // Do any additional setup after loading the view.
    }
    

   

}
