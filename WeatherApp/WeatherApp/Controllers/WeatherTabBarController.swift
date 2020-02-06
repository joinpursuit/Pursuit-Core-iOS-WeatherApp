//
//  WeatherTabBarController.swift
//  WeatherApp
//
//  Created by Ahad Islam on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabBarController: UITabBarController {
    
    private lazy var weatherVC: UINavigationController = {
        let rvc = ViewController()
        rvc.title = "Search"
        let vc = UINavigationController(rootViewController: rvc)
        return vc
    }()
    
    private lazy var favoritesVC: UINavigationController = {
        let rvc = FavoritesViewController()
        rvc.title = "Favorites"
        let vc = UINavigationController(rootViewController: rvc)
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        weatherVC.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        self.viewControllers = [weatherVC, favoritesVC]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
