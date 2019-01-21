//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    var unitState: Unit = .us {
        didSet{
            DispatchQueue.main.async {
                self.cityForecastCollectionView.reloadData()
            }
        }
    }
    var selectedCity = "New York"
    var weatherResult = [PeriodsWrapper](){
        didSet{
            DispatchQueue.main.async {
                self.cityForecastCollectionView.reloadData()
            }
        }
    }
    @IBOutlet weak var unitButton: UIBarButtonItem!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var cityForecastCollectionView: UICollectionView!
    @IBOutlet weak var zipCodTextField: UITextField!
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cityForecastCollectionView.delegate = self
    cityForecastCollectionView.dataSource = self
    zipCodTextField.delegate = self
    var defaultZipCode = "11103"
    if let zipcode = UserDefaults.standard.object(forKey: "ZipCodes") as? String{
        defaultZipCode = zipcode
    }
    getData(string: defaultZipCode)
    
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCell = sender as? UICollectionViewCell,
            let indexPath = cityForecastCollectionView.indexPath(for: selectedCell),
            let destination = segue.destination as? DetailedWeathersViewController else {return}
            destination.selectedCity = selectedCity
            destination.forecastSelected = weatherResult[indexPath.row]
    }
    
    @IBAction func unitButtonPressed(_ sender: Any) {
        if unitState == .us {
            unitState = .metric
        } else {
            unitState = .us
        }
    }
    
    private func getData(string: String){
        ZipCodeHelper.getLocationName(from: string) { (error, localityName, zipCode, state) in
            if let error = error {
                print("failed to get location name: \(error)")
                let alert = UIAlertController.init(title: "No Location Found", message: "", preferredStyle: UIAlertController.Style.alert)
                let okay = UIAlertAction.init(title: "Okay", style: .default, handler: { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okay)
                self.present(alert, animated: true, completion: nil)
            } else if let localityName = localityName{
                if let state = state {
                    let city = localityName.replacingOccurrences(of: " ", with: "+")
                    let keyword = "\(city.lowercased()),\(state.lowercased())"
                    UserDefaults.standard.set(keyword, forKey: "ZipCodes")
                    WeatherAndImageAPIClient.searchCityWeather(zipCode: keyword) { (appError, data) in
                        if let appError = appError {
                            print(appError.errorMessage())
                        }
                        if let data = data {
                            self.weatherResult = data
                        }
                    }
                    self.cityWeather.text = "The forecast for \(localityName)"
                    self.selectedCity = localityName
                }
                
            } else {
                print("No city found")
            }
            if let zipcode = zipCode{
                UserDefaults.standard.set(zipcode, forKey: "ZipCodes")
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        let weatherToSet = weatherResult[indexPath.row]

//        if unitState == .us{
//        cell.dateLabel.text = DateHelper.getDate(date: weatherToSet.dateTimeISO)
//        cell.weatherImage.image = ImageHelper.getWeatherImage(icon: weatherToSet.icon)
//        cell.highLabel.text = "High: \(weatherToSet.maxTempF.description)℉"
//        cell.lowLabel.text = "Low: \(weatherToSet.minTempF.description)℉"
//        } else {
            cell.dateLabel.text = DateHelper.getDate(date: weatherToSet.dateTimeISO)
            cell.weatherImage.image = ImageHelper.getWeatherImage(icon: weatherToSet.icon)
            cell.highLabel.text = "High: \(weatherToSet.maxTempC.description)℃"
            cell.lowLabel.text = "Low: \(weatherToSet.minTempC.description)℃"
//        }
        
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            getData(string: text)
        }
    return true
}
}
