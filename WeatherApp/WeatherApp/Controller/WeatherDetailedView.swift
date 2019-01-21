//
//  WeatherDetailedView.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailedView: UIViewController {

  
  @IBOutlet weak var cityName: UILabel!
  
  @IBOutlet weak var cityImage: UIImageView!
  
  
  @IBOutlet weak var moreInfo: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
  }
  
}
