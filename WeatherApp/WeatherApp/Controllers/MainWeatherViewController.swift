//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    @IBOutlet weak var unitSwitcher: UIBarButtonItem!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var locationTextField: UITextField!
    public var isMetric = false
    public var isValidZipcode = true
    private var presetZipcode = "74134"
    public var location = ""
    
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
    }
    
    private func checkForValidZipcode() -> Bool {
        if var keyword = locationTextField.text {
            if keyword == "" {
                keyword = presetZipcode
                isValidZipcode = true
            } else {
                isValidZipcode = true
                if keyword.count != 5 {
                    isValidZipcode = false
                } else {
                    for char in keyword {
                        if Int(String(char)) == nil {
                            isValidZipcode = false
                            break
                        }
                    }
                }
            }
        }
        return isValidZipcode
    }
    
    private func useValidZipcodeSetupViewAndUpdateUserDefaults(zipcodeIsValid: Bool, zipcode: String) {
        if zipcodeIsValid {
            searchWeather(fromZipcode: zipcode)
            UserDefaults.standard.set(zipcode, forKey: "Location")
            setupView(zipcode: zipcode)
        } else {
            showAlert()
        }
    }
    
    private func searchWeather(fromZipcode: String) {
        AerisAPIClient.searchLocation(zipcodeOrCity: fromZipcode, isZipcode: isValidZipcode) { (appError, dailyForecast) in
            if let appError = appError {
                print("searchWeather app error - \(appError)")
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
            zipcodeToSearch = presetZipcode
        }
        setupView(zipcode: zipcodeToSearch)
    }
    
    private func setupView(zipcode: String) {
        ZipCodeHelper.getLocationName(from: zipcode) { (appError, location) in
            if let appError = appError {
                print("appError in finding zipcode in setupView - \(appError)")
            } else if let location = location {
                self.locationLabel.text = "Weather Forecast for \(location)"
                self.location = location
            }
        }
        locationTextField.text = zipcode
        searchWeather(fromZipcode: zipcode)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Invalid Entry", message: "Please enter a valid zipcode", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension MainWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell
            else { return UICollectionViewCell() }
        let dayToSet = dailyForecast[indexPath.row]
        cell.date.text = WeatherDataHelper.formatISOToDate(dateString: dayToSet.dateTimeISO)
        if isMetric {
            cell.high.text = "High: " +  dayToSet.maxTempC.description + "°C"
            cell.low.text = "Low: " + dayToSet.minTempC.description + "°C"
        } else {
            cell.high.text = "High: " +  dayToSet.maxTempF.description + "°F"
            cell.low.text = "Low: " + dayToSet.minTempF.description + "°F"
        }
        cell.weatherImage.image = UIImage(named: dayToSet.icon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController else { return }
        destinationViewController.modalPresentationStyle = .overCurrentContext
        destinationViewController.dayWeather = dailyForecast[indexPath.row]
        destinationViewController.location = location
        self.present(destinationViewController, animated: true, completion: nil)
    }
}

extension MainWeatherViewController {
    @IBAction func doneViewing(_ segue: UIStoryboardSegue) {
    }
}

extension MainWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("percent encoding failed")
            return false
        }
        textField.resignFirstResponder()
        useValidZipcodeSetupViewAndUpdateUserDefaults(zipcodeIsValid: checkForValidZipcode(), zipcode: keyword)
        return true
    }
}
