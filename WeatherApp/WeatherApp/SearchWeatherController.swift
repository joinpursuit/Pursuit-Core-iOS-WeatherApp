//
//  SearchWeatherController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class SearchWeatherController: UIViewController {
    
    private let searchWeatherView = SearchWeatherView()
    
    override func loadView() {
        view = searchWeatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

}
