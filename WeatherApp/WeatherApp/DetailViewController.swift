//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(showSettings(_:)))
    }
    
    @objc
    private func showSettings(_ sender: UIBarButtonItem) {
        //print("show settings")
        
        // segue to SettingsVC, basically == prepare for segue
        
        let favoriteVC = FavoriteImageController()
        //navigationController?.presentedViewController(favoriteVC, animated: true)
        
        navigationController?.pushViewController(favoriteVC, animated: true)
        // if it would be just VC instead of this line we would use PRESENT, instead of push
        // IF WE WANT TO PRESENT IT MODALY USE THIS: present(settingsVC, animated: true)
        // try this - different stype
        //settingsVC.modalPresentationStyle = .overCurrentContext
        //settingsVC.modalTransitionStyle = .flipHorizontal
    }
    

}
