//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageOfLocation: UIImageView!
    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var weatherMoreInfoTextView: UITextView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    public var isMetric: Bool!
    public var location = ""
    public var dayWeather: DailyForecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = "Weather Forecast for \(location) \n \(WeatherDataHelper.formatISOToDate(dateString: dayWeather.dateTimeISO))"
        weatherDetailLabel.text = dayWeather.weather
        weatherMoreInfoTextView.text = WeatherDataHelper.formatMoreInfo(dailyForecast: dayWeather, isMetric: isMetric)
        imageActivityIndicator.startAnimating()
        PixabayAPIClient.getImageURLString(ofLocation: location) { (appError, urlString) in
            if let appError = appError {
                print("error getting pixabay image url string - \(appError)")
            } else if let urlString = urlString {
                ImageHelper.shared.fetchImage(urlString: urlString, completionHandler: { (appError, image) in
                    if let appError = appError {
                        print("error trying to get image out of pixabay url - \(appError)")
                        self.imageActivityIndicator.stopAnimating()
                        self.imageOfLocation.image = UIImage(named: "placeHolder")
                    } else if let image = image {
                        self.imageActivityIndicator.stopAnimating()
                        self.imageOfLocation.image = image
                    }
                })
            }
        }
        imageActivityIndicator.hidesWhenStopped = true
    }
    @IBAction func saveImage(_ sender: UIBarButtonItem) {
        if let image = imageOfLocation.image {
            if let imageToSave = image.jpegData(compressionQuality: 0.5) {
                let date = Date()
                let isoDateFormatter = ISO8601DateFormatter()
                isoDateFormatter.formatOptions = [.withFullDate,
                                                  .withFullTime,
                                                  .withInternetDateTime,
                                                  .withTimeZone,
                                                  .withDashSeparatorInDate]
                let timeStamp = isoDateFormatter.string(from: date)
                let favoriteImage = Favorite.init(addedDate: timeStamp, imageData: imageToSave)
                FavoritesModel.addFavoriteImage(favoriteImage: favoriteImage)
                showAlert(message: "Successfully favorited image")
            } else {
                print("image can't be compressed to jpeg")
                showAlert(message: "Can not favorite image")
            }
        } else {
            print("image does not exist")
            showAlert(message: "Can not favorite image")
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension WeatherDetailViewController: WeatherSettingDelegate {
    func changeToMetric() {
        isMetric = true
    }
    
    func changeToCustomary() {
        isMetric = false
    }
    
    
}
