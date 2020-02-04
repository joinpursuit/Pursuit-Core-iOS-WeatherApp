//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView = WeatherDetailView()
    
    public var weather: DailyDatum? 
    
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
    configureNavBar()
    }
    
    func updateUI() {
        guard let weatherInfo = weather else {
            fatalError(" could not get weather")
        }
        detailView.weatherLabel.text = weatherInfo.temperatureHigh.description
        detailView.weatherLabel.backgroundColor = .yellow
    }
    
    private func configureNavBar() {
        // set title of Navigation bar
        navigationItem.title = "Programmatic UI"
        
        // adding UIBarButtonItem to Navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addToFave(_:)))
    }
    @objc
    private func addToFave(_ sender: UIBarButtonItem) {
       // segue to the settingsVC
//        let settingsVC = SettingsViewController()
//        navigationController?.pushViewController(settingsVC, animated: true)
        
        // or this: Will present modally(different styles)
       // present(settingsVC, animated: true)
       // settingsVC.modalPresentationStyle = .overCurrentContext
        //settingsVC.modalTransitionStyle = .flipHorizontal
    }
    
}
