//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class DetailViewController: UIViewController {
    
    public var cityName = ""
    
    public var dataPersistance: DataPersistence<Hit>!
    
    private let detailView = DetailView()
    
    public var dailyWeather: DailyDatum?
    
    public var weather: Weather?
    
    public var picture: Hit?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        updateUI()
    }
    
    func updateUI() {
        guard let weatherCurrent = weather else {
            fatalError("could not get data for weatherCurrent")
        }
        guard let dailyweather = dailyWeather else {
            fatalError("could not get data for dailyweather")
        }
        
        let timeInterval: Double = Double(dailyweather.time)
        let date = Date(timeIntervalSince1970: timeInterval)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let dateString = dateFormatter.string(from: date)
        
        var timezone = weather?.timezone
        var cityFromLocation = timezone?.split(separator: "/")
        detailView.messageLabel.text = "\(cityName) for \(dateString)"
        
        
        detailView.weatherLabel.text = dailyweather.summary
        
        let timeIntervalForSunrise: Double = Double(dailyweather.sunriseTime)
        let dateSR = Date(timeIntervalSince1970: timeIntervalForSunrise)
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateStringSR = dateFormatter.string(from: dateSR)
        
        let timeIntervalForSunset: Double = Double(dailyweather.sunsetTime)
        let dateSS = Date(timeIntervalSince1970: timeIntervalForSunset)
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateStringSS = dateFormatter.string(from: dateSS)
        
        detailView.wholeWeatherInfoLabel.text = """
        High temperature: \(dailyweather.temperatureHigh)
        Low temperature: \(dailyweather.temperatureLow)
        Sunrise: \(dateStringSR)
        Sunset: \(dateStringSS)
        Windspeed: \(dailyweather.windSpeed)
        Inches of precipitation: \(dailyweather.precipProbability)
        """
        
        detailView.imageView.getImage(with: picture?.largeImageURL ?? "") {[weak self] (result) in
                switch result {
                case .failure:
                    print("cannot load image")
                    DispatchQueue.main.async {
                        self?.detailView.imageView.image = UIImage(systemName: "photo")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.detailView.imageView.image = image
                    }
                }
            }
        }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveFavoritePicturePressed(_:)))
    }
    
    @objc
    private func saveFavoritePicturePressed(_ sender: UIBarButtonItem) {
     //print("saved favorite picture pressed")
        guard let picture = picture else { return }
        do {
            // saving to document directory
            try dataPersistance.createItem(picture)
        } catch {
            print("error saving article: \(error)")
        }
    }
}
