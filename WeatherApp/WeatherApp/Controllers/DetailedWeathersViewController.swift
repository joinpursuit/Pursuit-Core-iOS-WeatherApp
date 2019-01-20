//
//  DetailedWeathersViewController.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedWeathersViewController: UIViewController {
    
    var selectedCity: String!
    var weatherData = [PeriodsWrapper]()
    
    var imageData = [Image.HitWrapper]() {
        didSet{
            let randomNumber = Int.random(in: 0...imageData.count)
            ImageHelper.fetchImage(url: imageData[randomNumber].largeImageURL) { (appError, image) in
                if let appError = appError {
                    print(appError)
                }
                if let image = image {
                    DispatchQueue.main.async {
                        self.cityImage.image = image
                    }
                }
            }
        }
    }
    @IBOutlet weak var cityImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedCity)
        WeatherAndImageAPIClient.getCityImages(city: selectedCity) { (appError, data) in
            if let error = appError{
                print(error)
            }
            if let data = data{
                self.imageData = data
            }
        }

    }
    

    

}
