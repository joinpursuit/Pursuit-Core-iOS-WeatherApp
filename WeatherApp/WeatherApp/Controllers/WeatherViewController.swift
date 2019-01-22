//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
var startingZip = "55415"
let startingCity = "New York"
var currentCity = ""

class WeatherViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var periods = [WeatherData]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var hits = [CityImages]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    nameLabel.text = "Weather in \(startingCity)"
    textField.text = startingZip
    
    WeatheAPIClient.searchWeatherEvent(isZipcode: true) { (appError, weather) in
        if let appError = appError {
            print(appError)
        }
        if let weather = weather {
            self.periods = weather.response[0].periods
        }
    }
    WeatheAPIClient.getCity(isZipcode: true) { (appError, cityImage) in
        if let appError = appError {
            print(appError)
        }
        if let cityImage = cityImage {
            self.hits = [cityImage]
        }
    }
}
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        print("Text did change: \(textField.text ?? "")")
    }

    @IBAction func sendButtonPress(_ sender: UIButton) {
        print(textField.text!)
        if textField.text?.count == 5 {
            startingZip = textField.text!
            ZipCodeHelper.getLocationName(from: startingZip) { (error, cityName) in
                if let error = error {
                    print(error)
                }
                if let cityName = cityName {
                    currentCity = cityName
                    self.nameLabel.text = "Weather in \(currentCity)"
                }
            }
            WeatheAPIClient.searchWeatherEvent(isZipcode: true) { (appError, weather) in
                if let appError = appError {
                    print(appError)
                }
                if let weather = weather {
                    self.periods = weather.response[0].periods
                }
            }
        } else {
            print("please enter a valid zip")
        }
    }
}

extension WeatherViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("the number of periods is \(periods.count)")
        return periods.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? WeatherCell else {return UICollectionViewCell()}
        
        let dataInfo = periods[indexPath.row]
        let imageString = dataInfo.icon
        let imageName = String(imageString.dropLast(4))
        
        let ISOdateString = dataInfo.dateTimeISO
        let simplifiedDateString = String(ISOdateString.dropLast(15))
        
        cell.currentDayLabel.text = simplifiedDateString
        cell.highLabel.text = "High: \(String(dataInfo.maxTempF))"
        cell.lowLabel.text = "Low: \(String(dataInfo.minTempF))"
        cell.imageViewCell.image = UIImage(named: imageName)
        return cell
        }
    }

