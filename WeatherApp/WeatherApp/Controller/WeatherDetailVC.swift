//
//  WeatherDetailVC.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var DetailPhoto: UIImageView!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var inchesOfParticipation: UILabel!

    var weather: WeatherInfo!
    var city: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        print(city)
    }
    
    func setUpLabels() {
        weatherCondition.text = weather.dateTimeISO
        sunset.text = "Sunset:\(weather.sunsetISO)"
        sunrise.text = "Sunrise:\(weather.sunriseISO)"
        
        
        if let rain = weather.percipIN{
            inchesOfParticipation.text = "Percipretation:\(rain)"
        }else {
            inchesOfParticipation.text = ""
        }
       
        windSpeed.text = "WindSpeed:\(weather.windSpeedMaxMPH)"
        if let highText = weather.maxTempF {
            high.text = "High:\(highText)"
        }
        if let lowText = weather.minTempF{
            low.text = "Low:\(lowText)"
        }
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func FavoriteButton(_ sender: UIBarButtonItem) {
        
        
    }
    
}
