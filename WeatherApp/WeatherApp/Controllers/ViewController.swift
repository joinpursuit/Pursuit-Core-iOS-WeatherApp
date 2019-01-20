//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {

    var selectedCity = "New York"
    var weatherResult = [PeriodsWrapper](){
        didSet{
            DispatchQueue.main.async {
                self.cityForecastCollectionView.reloadData()
            }
        }
    }
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var cityForecastCollectionView: UICollectionView!
    @IBOutlet weak var zipCodTextField: UITextField!
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    cityForecastCollectionView.delegate = self
    cityForecastCollectionView.dataSource = self
    zipCodTextField.delegate = self
    WeatherAndImageAPIClient.searchCityWeather(zipCode: "11103") { (appError, data) in
        if let appError = appError {
            print(appError.errorMessage())
        }
        if let data = data {
            self.weatherResult = data
        }
        ZipCodeHelper.getLocationName(from: "11103") { (error, localityName, zipcode) in
            if let error = error {
                print("failed to get location name: \(error)")
            } else if let localityName = localityName {
                self.cityWeather.text = "The forecast for \(localityName)"
            }
            
        }
        
    }
    
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailedWeathersViewController else {return}
            destination.selectedCity = selectedCity
            destination.weatherData = weatherResult
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        let weatherToSet = weatherResult[indexPath.row]
        cell.dateLabel.text = DateHelper.getDate(date: weatherToSet.dateTimeISO)
        cell.weatherImage.image = ImageHelper.getWeatherImage(icon: weatherToSet.icon)
        cell.highLabel.text = weatherToSet.maxTempF.description
        cell.lowLabel.text = weatherToSet.minTempF.description
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            ZipCodeHelper.getLocationName(from: text) { (error, localityName, zipCode) in
                    if let error = error {
                        print("failed to get location name: \(error)")
                        let alert = UIAlertController.init(title: "No ZipCode Found", message: "", preferredStyle: UIAlertController.Style.alert)
                        let okay = UIAlertAction.init(title: "Okay", style: .default, handler: { (UIAlertAction) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alert.addAction(okay)
                        self.present(alert, animated: true, completion: nil)
                    } else if let localityName = localityName {
                        self.cityWeather.text = "The forecast for \(localityName)"
                        self.selectedCity = localityName
                        
                
                    }
                if let zipcode = zipCode {
                    WeatherAndImageAPIClient.searchCityWeather(zipCode: zipcode) { (appError, data) in
                        if let appError = appError {

                            
                            print(appError.errorMessage())
                        }
                        if let data = data {
                            self.weatherResult = data
                        }
                }
                }
            }
         
        }
    return true
}
}
