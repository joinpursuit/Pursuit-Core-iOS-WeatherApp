//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageOfLocation: UIImageView!
    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var weatherMoreInfoTextView: UITextView!
    
    public var location = ""
    public var dayWeather: DailyForecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = "Weather Forecast for \(location) \n \(WeatherDataHelper.formatISOToDate(dateString: dayWeather.dateTimeISO))"
        imageOfLocation.image = UIImage(named: dayWeather.icon)
        weatherDetailLabel.text = dayWeather.weather
        weatherMoreInfoTextView.text = WeatherDataHelper.formatMoreInfo(dailyForecast: dayWeather)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MainWeatherViewController else { return }
        vc.delegate = self
    }
    
}

extension WeatherDetailViewController: WeatherHelperDelegate {
    func sendLocation(location: String) {
        self.locationLabel.text = "Weather Forecast for \(location)"
        self.location = location
    }
}
