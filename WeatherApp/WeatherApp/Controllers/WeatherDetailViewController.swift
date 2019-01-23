//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Genesis Mosquera on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var weatherFor: UILabel!
    
    @IBOutlet weak var cityImage: UIImageView!
    
    @IBOutlet weak var tempDescription: UILabel!
    
    @IBOutlet weak var tempHigh: UILabel!
    
    @IBOutlet weak var tempLow: UILabel!
    
    @IBOutlet weak var sunrise: UILabel!
    
    @IBOutlet weak var sunset: UILabel!
    
    @IBOutlet weak var windspeed: UILabel!
    
    @IBOutlet weak var precipitation: UILabel!
    
    public var dayInfo: Periods?
    public var images: ImageInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        if let dayInfo = dayInfo {
            //weatherFor.text =
        tempDescription.text = dayInfo.validTime
           //cityImage.image = ImageInfo 
            tempHigh.text = "High: \(dayInfo.maxTempF) °F"
            tempLow.text = "Low: \(dayInfo.minTempF) °F"
            sunrise.text = "Sunrise: \(dayInfo.sunrise)"
            sunset.text = "Sunset: \(dayInfo.sunset)"
            windspeed.text = "WindSpeed: \(dayInfo.windSpeedMPH) MPH"
            precipitation.text = "Precipitation (in.): \(dayInfo.precipIN) in."
        }
    }
    
}
