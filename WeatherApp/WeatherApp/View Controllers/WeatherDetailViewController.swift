//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    @IBOutlet weak var imageView: CacheImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    public var dayWeather: Temperature!
    public var location: String!
    public var pixabayInfo: URL?
    private var info = [Hits]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    private func updateUI() {
        guard let location = location else {return}
        titleLabel.text = "Weather Forecast for \(location) on \(dayWeather.dateTimeISO.formatFromISODateString(dateFormat: "yyyy-MM-d"))"
        weatherLabel.text = dayWeather.weather
        highLabel.text = "High: \(dayWeather.maxTempF)°F"
        lowLabel.text = "Low: \(dayWeather.minTempF)°F"
        sunriseLabel.text = "sunrise: \(dayWeather.sunriseISO.formatFromISODateString(dateFormat: "HH:mm:ss"))"
        sunsetLabel.text = "sunset: \(dayWeather.sunsetISO.formatFromISODateString(dateFormat: "HH:mm:ss"))"
        windspeedLabel.text = "Wind Speed: \(dayWeather.windSpeedMPH) MPH"
        precipitation.text = "precipitation: \(dayWeather.precipIN) inches"
        searchImage(fromLocation: location)
    }

    private func searchImage(fromLocation: String) {
        WeatherAPIClient.searchImage(location: location) { (appError, urlString) in
            if let appError = appError {
                print("error getting pixabay image url string - \(appError)")
            } else if let urlString = urlString {
                ImageHelper.shared.fetchImage(urlString: urlString, completionHandler: { (appError, image) in
                    if let appError = appError {
                        print("error trying to get image out of pixabay url - \(appError)")
                    } else if let image = image {
                        self.imageView.image = image
                    }
                })
            }
        }
    }
    private func saveImage()-> SavedImage? {
        guard let image = imageView.image else {return nil}
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return nil}
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = .medium
        let timestamp = formatter.string(from: date)
        let savedImage = SavedImage.init(imageData: imageData, createdAt: timestamp)
        return savedImage
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let image = saveImage() else {return}
        PixabayModel.appendImage(image: image)
        dismiss(animated: true, completion: nil)
    }
}
