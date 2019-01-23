//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var labelForSearchedCity: UILabel!
    @IBOutlet weak var weatherForTheWeekCollection: UICollectionView!
    @IBOutlet weak var userSearchTextField: UITextField!

    private var arrayOfWeatherDetails = [WeatherDetailData]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherForTheWeekCollection.reloadData()
            }
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherForTheWeekCollection.dataSource = self
    labelForSearchedCity.text = "Weather"
    userSearchTextField.delegate = self
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherDetailSegue" {
            let detailsVC = segue.destination as! WeatherDetailViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = self.weatherForTheWeekCollection.indexPath(for: cell)
            detailsVC.weatherDataToPass = arrayOfWeatherDetails[indexPath!.row]
            detailsVC.sendOverThatCityName = labelForSearchedCity.text
        }
        
    }

}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfWeatherDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherForTheWeekCollection.dequeueReusableCell(withReuseIdentifier: "dailyWeatherForecastCell", for: indexPath) as? WeatherDataCollectionViewCell else {return UICollectionViewCell()}
        let currentDayWeather = arrayOfWeatherDetails[indexPath.item]
        cell.weatherHigh.text = "High: \(String(currentDayWeather.maxTempF))"
        cell.weatherLow.text = "Low: \(String(currentDayWeather.minTempF))"
        cell.weatherIconImage.image = UIImage(named: currentDayWeather.icon)
        cell.weatherDateLabel.text = currentDayWeather.dateTimeISO.formatFromISODateString(dateFormat: "MMMM d, yyyy")
        return cell
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let zipcode = userSearchTextField.text
        ZipCodeHelper.getLocationName(from: zipcode!) { (error, localName) in
            if error != nil {
                self.labelForSearchedCity.text = "Location Not Found"
                print("eror")
        }
            if let localName = localName {
                self.labelForSearchedCity.text = localName
                print("local")
            }
        }
        WeatherAPIClient.searchWeatherByZipcode(zipcode: zipcode!) { (error, weather) in
            if let error = error {
                print(error.errorMessage())
            } else if let weather = weather {
                self.arrayOfWeatherDetails = weather
            }
        }
        return true
    }
    
}
    

