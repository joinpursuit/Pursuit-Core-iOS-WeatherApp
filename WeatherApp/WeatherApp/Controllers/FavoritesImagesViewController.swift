//
//  FavoritesImagesViewController.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesImagesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var favirite = [CityImages.HitWrapper]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
