//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    public var dailyWeather: DailyDatum?
    
    public var weather: Weather?
    
   // private var pictures = [Hit]? {
//           didSet {
//               DispatchQueue.main.async {
//                self.pictures.
//               }
//           }
//       }
    
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
        detailView.messageLabel.text = "Weather For \(String(cityFromLocation?.last ?? "")) for \(dateString)"
        
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
        
//        // String(cityFromLocation?.last ?? "New York")
//        detailView.imageView.getImage(with: ) {[weak self]
//            (result) in
//            switch result {
//            case .failure(let appError):
//                print("error \(appError)")
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self?.detailView.imageView.image = image
//                }
//            }
//        }
    }
 

    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(showSettings(_:)))
    }
    
    @objc
    private func showSettings(_ sender: UIBarButtonItem) {
        //print("show settings")
        
        // segue to SettingsVC, basically == prepare for segue
        
        let favoriteVC = FavoriteController()
        //navigationController?.presentedViewController(favoriteVC, animated: true)
        
        navigationController?.pushViewController(favoriteVC, animated: true)
        // if it would be just VC instead of this line we would use PRESENT, instead of push
        // IF WE WANT TO PRESENT IT MODALY USE THIS: present(settingsVC, animated: true)
        // try this - different stype
        //settingsVC.modalPresentationStyle = .overCurrentContext
        //settingsVC.modalTransitionStyle = .flipHorizontal
    }
    

}
