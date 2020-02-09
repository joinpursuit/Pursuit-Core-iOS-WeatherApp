//
//  WeatherTabBarControllerViewController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class WeatherTabBarControllerViewController: UITabBarController {
    
    private var dataPersistance = DataPersistence<Hit>(filename: "savedPictures.plist")
    
    private lazy var searchWeatherController: SearchWeatherController = {
           let viewcontroller = SearchWeatherController()
        viewcontroller.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewcontroller.dataPersistance = dataPersistance
        return viewcontroller
       }()
    
    private lazy var favoriteImageController: FavoriteController = {
        let favoriteStoryboard = UIStoryboard(name: "FavoriteStoryboard", bundle: nil)
        
        guard let viewcontroller = favoriteStoryboard.instantiateViewController(identifier: "FavoriteController") as? FavoriteController else {
            fatalError("could not load FavoriteController")
        }
        viewcontroller.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 1)
        viewcontroller.dataPersistance = dataPersistance
       // viewcontroller.dataPersistance.delegate = dataPersistance as! DataPersistenceDelegate
        return viewcontroller
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // just this simple line of code embeds VC to NAvigation Controller
        viewControllers = [UINavigationController(rootViewController: searchWeatherController), UINavigationController(rootViewController: favoriteImageController)]
    }

}
