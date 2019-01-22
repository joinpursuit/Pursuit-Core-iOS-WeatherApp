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
    
    var weatherDetails:PeriodsInformation!
    var weatherImage: ImageDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupDetailView()
    }
    
    func SetupDetailView(){
        high.text = "\(weatherDetails.maxTempF)"
        low.text = "\(weatherDetails.minTempF)"
        sunset.text = "\(weatherDetails.sunset)"
        sunrise.text = "\(weatherDetails.sunrise)"
        weatherDescription.text = weatherDetails.weather
        windSpeed.text = "\(weatherDetails.windSpeedMaxMPH)"
        prescipitation.text = "\(weatherDetails.weatherPrimary)"
        
        
        WeatherAPIClient.getImages(city: "Chicago") { (error, imageURL) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = imageURL {
                
                ImageHelper.shared.fetchImage(urlString: data[Int.random(in: 0...data.count-1)].largeImageURL) { (error, image) in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let image = image {
                        self.weatherPhotoView.image = image
                    }
                }
                
            }
        }
        
     
    }
}
