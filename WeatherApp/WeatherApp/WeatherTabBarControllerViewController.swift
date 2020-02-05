//
//  WeatherTabBarControllerViewController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabBarControllerViewController: UITabBarController {
    
    private lazy var searchWeatherController: SearchWeatherController = {
           let viewcontroller = SearchWeatherController()
        viewcontroller.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return viewcontroller
       }()
    
    private lazy var favoriteImageController: FavoriteController = {
    let viewcontroller = FavoriteController()
        viewcontroller.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 1)
        return viewcontroller
    }()
    
//    private lazy var detailViewController: DetailViewController = {
//    let viewcontroller = DetailViewController()
//        //viewcontroller.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 1)
//        return viewcontroller
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // just this simple line of code embeds VC to NAvigation Controller
        viewControllers = [UINavigationController(rootViewController: searchWeatherController), favoriteImageController]
    }

}
