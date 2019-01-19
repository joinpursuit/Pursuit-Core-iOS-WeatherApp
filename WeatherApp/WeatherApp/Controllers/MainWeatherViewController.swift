//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var locationTextField: UITextField!
    public var isValidZipcode = true
    private var defaultZipcode = "11219"
    
    private var dailyForecast = [DailyForecast]() {
        didSet {
            DispatchQueue.main.async {
                self.forecastCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchForDefaultSearchSettings()
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        locationTextField.delegate = self
     //   checkForNewLocationEntered()
    
    }
    
    
    
    private func checkForNewLocationEntered() {
        if var keywordEntered = locationTextField.text {
            if keywordEntered == "" {
                keywordEntered = "10023"
                self.isValidZipcode = true
            } else {
                isValidZipcode = true
                for char in keywordEntered {
                    if Int(String(char)) == nil {
                        isValidZipcode = false
                        break
                    }
                }
            }
        if isValidZipcode {
            searchWeather(keyword: keywordEntered)
            print("now searching for \(keywordEntered)'s weather")
        }
        UserDefaults.standard.set(keywordEntered, forKey: "Location")
        }
    }
    
    
    private func searchWeather(keyword: String) {
        guard let encodedSearchTerm = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("percent encoding failed")
            return
        }
        AerisAPIClient.searchLocation(keyword: encodedSearchTerm, isZipcode: isValidZipcode) { (appError, dailyForecast) in
            if let appError = appError {
                print(appError)
            } else if let dailyForecast = dailyForecast {
                self.dailyForecast = dailyForecast
            }
        }
    }

    private func searchForDefaultSearchSettings() {
        var zipcodeToSearch = ""
        if let searchWord = UserDefaults.standard.object(forKey: "Location") as? String {
            zipcodeToSearch = searchWord
        } else {
            zipcodeToSearch = defaultZipcode
        }
        setupView(zipcode: zipcodeToSearch)
    }
    
    private func setupView(zipcode: String) {
        ZipCodeHelper.getLocationName(from: zipcode) { (appError, location) in
            if let appError = appError {
                print("appError in finding zipcode in setupView - \(appError)")
            } else if let location = location {
                self.locationLabel.text = "Weather Forecast for \(location)"
            }
        }
        locationTextField.text = zipcode
        searchWeather(keyword: zipcode)
    }

}

extension MainWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 150, height: 265)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell
            else {
            print("unable to dequeue daycell")
            return UICollectionViewCell()
        }
        let dayToSet = dailyForecast[indexPath.row]
        cell.date.text = dayToSet.dateTimeISO
        cell.high.text = "High: " +  dayToSet.maxTempF.description + "°F"
        cell.low.text = "Low: " + dayToSet.minTempF.description + "°F"
        cell.weatherImage.image = UIImage(named: dayToSet.icon)
        return cell
    }
}

extension MainWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkForNewLocationEntered()
        return true
    }
}
