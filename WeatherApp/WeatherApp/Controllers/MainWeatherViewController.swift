//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    private var dailyForecast = [DailyForecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        AerisAPIClient.searchLocation(keyword: "11219", isZipcode: true) { (appError, dailyForecast) in
            if let appError = appError {
                print(appError)
            } else if let dailyForecast = dailyForecast {
                self.dailyForecast = dailyForecast
            }
        }
        print(dailyForecast.count)
  }


}

