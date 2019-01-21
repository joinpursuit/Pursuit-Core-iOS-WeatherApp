//
//  DetailedWeathersViewController.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedWeathersViewController: UIViewController {
    
    var selectedCity: String!
    var forecastSelected: PeriodsWrapper!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageData = [Image.HitWrapper]() {
        didSet{
            
            let randomNumber = Int.random(in: 0...imageData.count - 1)
            ImageHelper.fetchImage(url: imageData[randomNumber].largeImageURL) { (appError, image) in
                if let appError = appError {
                    print(appError)
                }
                if let image = image {
                    DispatchQueue.main.async {
                        self.cityImage.image = image
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    if let image = UIImage(named: self.forecastSelected.icon){
                        self.cityImage.image = image
                        self.activityIndicator.stopAnimating()
                    }
            }
            }
                
            
        }
    }
    @IBOutlet weak var cityImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        //        print(selectedCity)
        self.activityIndicator.startAnimating()
        if let image = UIImage(named: forecastSelected.icon){
            cityImage.image = image
            
        }
        cityNameLabel.text = "\(selectedCity!) - \(DateHelper.getDate(date: forecastSelected.dateTimeISO))"
        weatherLabel.text = "\(forecastSelected.weather)"
        highLabel.text = "High: \(forecastSelected.maxTempF)℉"
        lowLabel.text = "Low: \(forecastSelected.minTempF)℉"
        sunriseLabel.text = "Sunrise: \(DateHelper.getTime(time: forecastSelected.sunriseISO))"
        sunsetLabel.text = "Sunset: \(DateHelper.getTime(time: forecastSelected.sunsetISO))"
        windSpeedLabel.text = "Wind speeds: \(forecastSelected.windSpeedMPH) MPH"
        precipitationLabel.text = "Inches of precipitation: \(forecastSelected.precipIN)"
        WeatherAndImageAPIClient.getCityImages(city: selectedCity) { (appError, data) in
            if let error = appError{
                if let image = UIImage(named: self.forecastSelected.icon){
                    DispatchQueue.main.async {
                        self.cityImage.image = image
                        self.activityIndicator.stopAnimating()
                        print(error)
                    }
                }
            }
            if let data = data{
                self.imageData = data
            }
        }
        
    }
    @IBAction func saveWasPressed(_ sender: Any) {
        let alert = UIAlertController.init(title: "Image Saved!", message: nil, preferredStyle: .alert)
        let okay = UIAlertAction.init(title: "Okay", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
        if let image = cityImage.image{
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = dateformatter.string(from: Date())
            let favoriteAt = DateHelper.getDate(date: now)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return print("No ImageData")}
            
            let favoriteImage = FavoriteImage.init(favoritedAt: favoriteAt, imageData: imageData)
            DataPersistanceModel.favoriteImage(image: favoriteImage)
            
            }
        }
}
    


