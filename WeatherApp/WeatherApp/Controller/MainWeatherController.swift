//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainWeatherController: UIViewController {
  
  
  @IBOutlet weak var weatherDisplayColletionView: UICollectionView!
  
  @IBOutlet weak var cityName: UILabel!
  
  @IBOutlet weak var zipCodeField: UITextField!
  
  @IBOutlet weak var zipCodeMessage: UILabel!
  
  
  var arrayOfWeatherDetails = [WeatherDetails]() {
    didSet {
      DispatchQueue.main.async {
        self.weatherDisplayColletionView.reloadData()
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchWeatherForecast()
    zipCodeField.delegate = self
    weatherDisplayColletionView.dataSource = self
    weatherDisplayColletionView.delegate = self
    dump(arrayOfWeatherDetails)
  }
  
  private func searchWeatherForecast(keyword: String = "11101"){
    WeatherAPIClient.searchWeather(keyword: keyword) { (appError, weather) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let weather = weather {
        print("found \(weather.count) podcast")
        dump(weather)
        if let details = weather[weather.count - 1].periods {
          self.arrayOfWeatherDetails = details
        }
        
        //TODO: Refactor outside this function
        //        if let city = weather[weather.count - 1].profile?.cityName {
        //          DispatchQueue.main.async {
        //            self.cityName.text = city
        //          }
        //        }
      }
    }
  }
}

extension MainWeatherController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfWeatherDetails.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = weatherDisplayColletionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionCell else {return UICollectionViewCell()}
    
    
    let currentDayWeather = arrayOfWeatherDetails[indexPath.row]
    
    cell.configureCell(weatherForecast: currentDayWeather)
    
    return cell
  }
}

extension MainWeatherController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: weatherDisplayColletionView.bounds.width, height: weatherDisplayColletionView.bounds.height)
  }
}

extension MainWeatherController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 
    textField.resignFirstResponder()
    
    if let text = textField.text {
      ZipCodeHelper.getLocationName(from: text) { (error, localityName) in
        
        if let error = error {
          print("Couldn't locate the city. There was an \(error)")
        }
        if let localityName = localityName {
          self.cityName.text = localityName
        }
        
      }
      
    }
    return true
  }
}
