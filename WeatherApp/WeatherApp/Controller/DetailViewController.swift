//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Biron Su on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var weather: WeatherInfo!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLocationDate: UILabel!
    @IBOutlet weak var detailWeatherLocation: UILabel!
    @IBOutlet weak var detailHigh: UILabel!
    @IBOutlet weak var detailLow: UILabel!
    @IBOutlet weak var detailSunrise: UILabel!
    @IBOutlet weak var detailSunset: UILabel!
    @IBOutlet weak var detailWindspeed: UILabel!
    @IBOutlet weak var detailInchesOfSomething: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = UIImage(named: weather.icon)
    }
}
