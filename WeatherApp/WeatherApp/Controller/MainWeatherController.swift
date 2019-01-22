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
  
  private var zipCodeText = "11101"
  
  var arrayOfWeatherDetails = [WeatherDetails]() {
    didSet {
      DispatchQueue.main.async {
        self.weatherDisplayColletionView.reloadData()
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDefaultForeCastCity(zipCode: zipCodeText)
    zipCodeField.delegate = self
    searchWeatherForecast(zipCode: zipCodeText)
    weatherDisplayColletionView.dataSource = self
    weatherDisplayColletionView.delegate = self
  }
  
  private func searchWeatherForecast(zipCode: String){
    WeatherAPIClient.searchWeather(zipCode: zipCode) { (appError, weather) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let weather = weather {
        
        //TODO: I'm getting an error when i enter a city name
        
        if let details = weather[weather.count - 1].periods {
          self.arrayOfWeatherDetails = details
        }
      }
    }
  }
  
  
  private func setUpDefaultForeCastCity(zipCode: String){
    ZipCodeHelper.getLocationName(from: zipCode) { (error, localityName) in
      if let error = error {
        print("Couldn't locate the city. There was an \(error)")
      }
      if let localityName = localityName {
        self.cityName.text = localityName
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    guard let detailedVC = storyboard.instantiateViewController(withIdentifier: "DetailedView") as? WeatherDetailedView else {return}
    
    detailedVC.modalPresentationStyle = .overCurrentContext
    detailedVC.receiveCityInfo = arrayOfWeatherDetails[indexPath.row]
        
    navigationController?.pushViewController(detailedVC, animated: true)
    
    
  }
}

extension MainWeatherController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    
    textField.resignFirstResponder()
    
    if let text = textField.text {
      zipCodeText = text
      
      ZipCodeHelper.getLocationName(from: text) { (error, localityName) in
        if let error = error {
          print("Couldn't locate the city. There was an \(error)")
        }
        if let localityName = localityName {
          self.cityName.text = localityName
          self.searchWeatherForecast(zipCode: text)
          
        }
      }
      
    }
    
    return true
  }
}
