//
//  WeatherDetailedViewController.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailedViewController: UIViewController {
    @IBOutlet weak var forecastName: UILabel!
    @IBOutlet weak var backgrouundimage: UIImageView!
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
    
    var cityName = ""
       
    
    var formattedCityName:String!{
        return cityName.replacingOccurrences(of: " ", with: "+")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupDetailView()
        backgrouundimage.image = UIImage.init(named: "morning")
    }
    
    func setNotification(){
        let alert = UIAlertController(title: "Saved", message: "Image saved successfully", preferredStyle: .alert)
        
        let saved = UIAlertAction.init(title:"Saved", style: .default){
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(saved)
        present(alert,animated: true,completion: nil)
    }
    
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Options", message: "Save Image", preferredStyle: .actionSheet)
    
        let save = UIAlertAction.init(title: "Save", style: .default) { (alert: UIAlertAction) in
            
            let favoritedImage = SavedImage.init(imageURL: self.weatherImage?.largeImageURL ?? "")
            SavedImageModel.save(image: favoritedImage)
            self.setNotification()
            
            
        }
        let cancel = UIAlertAction.init(title: "Cancel", style: .destructive) { (alert: UIAlertAction) in
        }

        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func okay(){
        let alert = UIAlertController(title: "Saved", message: "Successfully saved image", preferredStyle: .alert)
        
        let saved = UIAlertAction.init(title: "Saved", style: .default) {
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(saved)
        present(alert,animated: true , completion: nil)
        
    }
    
    
    
    
    
    
    func SetupDetailView(){
        high.text = "High: \(weatherDetails.maxTempF) F"
        low.text = "Low: \(weatherDetails.minTempF) F"
        sunset.text = "Sunset: \(weatherDetails.sunsetTime) pm"
        sunrise.text = "Sunrise: \(weatherDetails.sunriseTime) am"
        weatherDescription.text = weatherDetails.weather
        windSpeed.text = "Wind speed: \(weatherDetails.windSpeedMaxMPH) MPH"
        prescipitation.text = "Prescipitation: \(weatherDetails.precipMM) F"
        forecastName.text = "Weather Forecast for \(cityName) for \(weatherDetails.dateFormattedString)"
    
        WeatherAPIClient.getImages(city: formattedCityName) { (error, imageURL) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = imageURL {
                  let randomImage = data[Int.random(in: 0...data.count-1)]
                DispatchQueue.main.async {
                    self.weatherImage = randomImage
                }
                ImageHelper.shared.fetchImage(urlString: randomImage.largeImageURL) { (error, image) in
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
