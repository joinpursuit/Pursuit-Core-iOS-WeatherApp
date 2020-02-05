//
//  FavoriteImageController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // FIXME: write extension for this tableView:
        //tableView.dataSource = self
        //tableView.delegate = self
        
       // FIXME: I register here tableView cell, but I think I need to create tableView on FavoriteView.swift (look how did we do with collection view)
        // tableView.register(UINib(nibName: "FavoriteImageCell", bundle: nil), forCellReuseIdentifier: "favoriteImageCell")))
    }

}

