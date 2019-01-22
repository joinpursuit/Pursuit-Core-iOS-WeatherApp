//
//  WeatherDetailedViewController.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailedViewController: UIViewController {
    @IBOutlet weak var saveButton: UIToolbar!
    @IBOutlet weak var weatherPhotoView: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var prescipitation: UILabel!
    
    var weatherDetails:WeatherFocasts!
    var weatherImage: ImageDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupDetailView()
    }
    
    func SetupDetailView(){
        high.text = "\(weatherDetails.periods[0].maxTempF)"
        low.text = "\(weatherDetails.periods[0].minTempF)"
        sunset.text = "\(weatherDetails.periods[0].sunset)"
        sunrise.text = "\(weatherDetails.periods[0].sunrise)"
        weatherDescription.text = weatherDetails.periods[0].weather
        windSpeed.text = "\(weatherDetails.periods[0].windSpeedMaxMPH)"
        prescipitation.text = "\(weatherDetails.periods[0].weatherPrimary)"
        
        ImageHelper.shared.fetchImage(urlString: weatherImage.largeImage) { (error, image) in
            if let error = error {
                print("Error: \(error)")
            } else if let image = image {
                self.weatherPhotoView.image = image
            }
        }
    }
}
