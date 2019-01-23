//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Jeffrey Almonte on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var zipeCodeTextField: UITextField!
    var forecasts = [Periods]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
            }
        }
    }
    public var isZipCode = true
    public var myLocation = ""
//    public var myZipCode = "11208" {
//        didSet {
//           ZipCodeHelper.g
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        zipeCodeTextField.delegate = self
        
    }
    
    func getForecasts(keyword: String) {
        WeatherAPIClient.searchWeather(keyword: keyword) { (appError, forecasts) in
            if let appError = appError {
                print("appError in finding Zip Code \(appError)")
            } else if let forecasts = forecasts {
                self.forecasts = forecasts
                dump(forecasts)
            }
        }
    }
    
    
     
   

 
    
}
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UICollectionViewCell()}
        
          let currentForecast = forecasts[indexPath.row]
       cell.date.text = currentForecast.sunriseISO
        cell.highTemp.text = "Hight of \(currentForecast.maxTempF.description)"
        cell.lowTemp.text = "Low of \(currentForecast.minTempF.description)"
       cell.weatherIcon.image = UIImage.init(named: currentForecast.icon)
        return cell
    }
    
    
}
extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let zipcodeTextFieldText = zipeCodeTextField.text
       
        WeatherAPIClient.searchWeather(keyword: zipcodeTextFieldText!) { (error, results) in
            if let error = error {
                print(error.errorMessage())
            } else if let results = results {
                DispatchQueue.main.async {
                    self.forecasts = results
                }
            }
       // textField.resignFirstResponder()
        
     }
        return true
        
    }
    
}
