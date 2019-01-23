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
    
    var detailForcast: ForcastData!
    var detailLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPixaImage()
    }
    
    func getPixaImage() {
        PixabayAPIClient.searchWeather(keyword: detailLocation.replacingOccurrences(of: " ", with: "")) { (error, imageData) in
            if let error = error {
                print(error.errorMessage())
            } else if let imageData = imageData {
                let randomNumber = Int.random(in: 0...imageData.count - 1)
                ImageHelper.fetchImage(url: imageData[randomNumber].largeImageURL) { (appError, image) in
                    if let appError = appError {
                        print(appError)
                    }
                    if let image = image {
                        DispatchQueue.main.async {
                            self.detailCityImage.image = image
                        }
                    } else {
                        let image = UIImage(named: self.detailForcast.icon)
                        self.detailCityImage.image = image
                    }
                }
            }
        }
    }
    func setupUI() {
        if let detailInfo = detailForcast {
            detailHighTemp.text = "High: \(detailInfo.maxTempF)°F"
            detailLowTemp.text = "Low: \(detailInfo.minTempF)°F"
            detailSunset.text = "Sunset: \(DateTimeHelper.formatISOToTime(dateString: detailInfo.sunsetISO))"
            detailSunrise.text = "Sunrise: \(DateTimeHelper.formatISOToTime(dateString: detailInfo.sunriseISO))"
            detailWindspeed.text = "Windspeed: \(detailInfo.windSpeed80mMPH)MPH"
            detailPercipitation.text = "Precipitation in Inches: \(detailInfo.precipIN)"
            weatherLabel.text = detailInfo.weather
            detailTitle.text = "Weather Forcast for \(detailLocation) for \(DateTimeHelper.formatISOToDate(dateString: detailInfo.dateTimeISO))"
            
        }
    }

    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "Saved!", message: "Image Saved To Favorites", preferredStyle: .alert)
        let okay = UIAlertAction.init(title: "Okay", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
        if let image = detailCityImage.image{
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = dateformatter.string(from: Date())
            let favoriteAt = DateTimeHelper.formattedDate(date: now)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return print("No ImageData")}
            
            let favoriteImage = FavoritedImage.init(favoritedAt: favoriteAt, imageData: imageData)
            DataPersistanceModel.favoriteImage(image: favoriteImage)
        }
    }
}
