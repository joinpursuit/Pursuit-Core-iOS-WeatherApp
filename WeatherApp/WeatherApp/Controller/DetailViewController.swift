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
    var locationName: String!
    var weatherImage: Data!
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLocationDate: UILabel!
    @IBOutlet weak var detailWeatherLocation: UILabel!
    @IBOutlet weak var detailHigh: UILabel!
    @IBOutlet weak var detailLow: UILabel!
    @IBOutlet weak var detailSunrise: UILabel!
    @IBOutlet weak var detailSunset: UILabel!
    @IBOutlet weak var detailWindspeed: UILabel!
    @IBOutlet weak var detailInchesOfSomething: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage()
        detailLocationDate.text = "Weather for \(locationName!) on \(WeatherDateHelper.formatISOToDate(dateString: weatherDetail.dateTimeISO))"
        detailWeatherLocation.text = "\(weatherDetail.weather)"
        detailHigh.text = "High: \(weatherDetail.maxTempF)℉"
        detailLow.text = "Low: \(weatherDetail.minTempF)℉"
        detailSunset.text = "Sunset: \(WeatherDateHelper.formatISOToTime(dateString: weatherDetail.sunsetISO))"
        detailSunrise.text = "Sunrise: \(WeatherDateHelper.formatISOToTime(dateString: weatherDetail.sunriseISO))"
        detailWindspeed.text = "Windspeed: \(weatherDetail.windSpeedMaxMPH) MPH"
        detailInchesOfSomething.text = "Inches of percipitation: \(weatherDetail.precipIN)"
    }
    func updateImage() {
        WeatherAPIClient.getImage(keyword: locationName!.replacingOccurrences(of: " ", with: "")) { (error, url) in
            if let error = error {
                print("My code aint working \(error)")
            } else if let url = url {
                ImageHelper.shared.fetchImage(urlString: url.absoluteString, completionHandler: { (error, image) in
                    if let error = error {
                        print("error on the image helper: \(error)")
                    } else if let image = image {
                        DispatchQueue.main.async {
                            self.weatherImage = image.jpegData(compressionQuality: 0.5)
                            self.detailImageView.image = image
                        }
                    }
                })
            }
        }
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        FavoriteImageModel.addImage(image: weatherImage)
    }
}
