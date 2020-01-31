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
    
//    private var podcasts = [Podcast]() {
//      didSet {
//        // 13.
//          DispatchQueue.main.async {
//              self.podcastView.collectionView.reloadData()
//          }
//      }
//    }
    
    override func loadView() {
        view = searchWeatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Weather Search"
    }

}
