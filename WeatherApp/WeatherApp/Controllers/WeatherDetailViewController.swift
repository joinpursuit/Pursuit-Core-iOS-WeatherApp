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
    
    public var dayInfo: Periods!
    public var images = [ImageInfo]()
    public var cityName: String?
    public var locationName = ""
    
    //        didSet {
    //            DispatchQueue.main.async {
    //                self.images.reload
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        getImage()
//                ImageHelper.shared.fetchImage(urlString: "https://pixabay.com//get/e835b20e2ff4073ed1584d05fb1d4797e071e4dc1eb70c4090f4c97bafe9b2b1de_1280.jpg") { (appError, image) in
//                    if let appError = appError {
//                        print(appError.errorMessage())
//                    } else if let image = image {
//                        self.cityImage.image = image
//                    }
//                }
    }
    private func getImage() {
        if let cityName = cityName {
            PixabayAPIClient.searchCity(city: cityName, isCity: true) { (appError, imageData) in
                if let error = appError {
                    print(error)
                } else if let imageData = imageData {
                    let randomImageURL = imageData[Int.random(in: 0...imageData.count - 1)].largeImageURL
                    ImageHelper.shared.fetchImage(urlString: randomImageURL , completionHandler: { (appError, image) in
                        if let appError = appError {
                            print(appError)
                        } else if let image = image {
                            DispatchQueue.main.async {
                                self.cityImage.image = image
                            }
                        }
                    })

                }
            }
        }
    }
    
    
    private func updateUI() {
        if let dayInfo = dayInfo {
            weatherFor.text = cityName
            tempDescription.text = ("\(dayInfo.dateFormattedTime)")
            
            //            cityImage.image = UIImage.init(named: images.largeImageURL)
            tempHigh.text = "High: \(dayInfo.maxTempF) °F"
            tempLow.text = "Low: \(dayInfo.minTempF) °F"
            
            sunrise.text = "Sunrise: \(dayInfo.dateFormattedSunrise)"
            sunset.text = "Sunset: \(dayInfo.dateFormattedSunset)"
            windspeed.text = "WindSpeed: \(dayInfo.windSpeedMPH) MPH"
            precipitation.text = "Precipitation (in.): \(dayInfo.precipIN) in."
        }
    }
    
}
