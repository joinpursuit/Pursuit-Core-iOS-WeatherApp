//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
     var selectedWeatherImage: WeatherData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var imageInfo = [CityImages]() {
        didSet {
            let image = Int.random(in: 0..<imageInfo.count)
            ImageHelper.fetchImages(url: imageInfo[image].largeImageURL) { (appError, image) in
                if let appError = appError {
                    print("App Error is: \(appError)")
                }
                if let image = image {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } else {
                    if let selectedImage = UIImage(named: self.selectedWeatherImage.icon) {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}
