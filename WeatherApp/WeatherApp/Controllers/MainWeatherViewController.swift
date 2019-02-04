//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

protocol WeatherSettingDelegate: AnyObject {
    func changeToMetric()
    func changeToCustomary()
}

class MainWeatherViewController: UIViewController {
    
    @IBOutlet weak var unitSwitcher: UIBarButtonItem!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var locationTextField: UITextField!
    public var isMetric = false {
        didSet {
            forecastCollectionView.reloadData()
        }
    }
    public var isValidZipcode = true
    public var location = ""
    private var presetZipcode = "74134"
    
    weak var delegate: WeatherSettingDelegate?
    
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
    
    private func useSearchResultToSetupView(zipcodeIsValid: Bool, keyword: String) {
        if zipcodeIsValid {
            searchWeather(keyword: keyword, isZipcode: zipcodeIsValid)
            UserDefaults.standard.set(keyword, forKey: "Location")
            setupView(keyword: keyword)
        } else {
            showAlert(message: "Please enter a valid 5-digit zipcode")
        }
    }
    
    private func searchWeather(keyword: String, isZipcode: Bool) {
        AerisAPIClient.searchLocation(zipcodeOrCity: keyword, isZipcode: isValidZipcode) { (appError, dailyForecast) in
            if let appError = appError {
                print("searchWeather app error - \(appError)")
            } else if let dailyForecast = dailyForecast {
                    self.dailyForecast = dailyForecast
                    UserDefaults.standard.set(keyword, forKey: "Location")
                } else {
                    self.showAlert(message: "Zipcode should be a five-digit number and location should be formatted as City, State")
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
        setupView(keyword: zipcodeToSearch)
    }
    
    private func setupView(keyword: String) {
        ZipCodeHelper.getLocationName(from: keyword) { (appError, location) in
            if let appError = appError {
                print("appError in finding zipcode in setupView - \(appError)")
                self.locationLabel.text = "Weather Forecast for \(keyword.capitalized)"
                self.location = ""
            } else if let location = location {
                self.locationLabel.text = "Weather Forecast for \(location)"
                self.location = location
            }
        }
        locationTextField.text = keyword.replacingOccurrences(of: "%20", with: "")
        searchWeather(keyword: keyword, isZipcode: isValidZipcode)
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func unitSwitcherPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Customary" {
            isMetric = false
            sender.title = "Metric"
            self.delegate?.changeToCustomary()
        } else {
            isMetric = true
            sender.title = "Customary"
            self.delegate?.changeToMetric()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let weatherDetailViewController = segue.destination as! WeatherDetailViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = self.forecastCollectionView.indexPath(for: cell)
        weatherDetailViewController.dayWeather = dailyForecast[indexPath!.row]
        weatherDetailViewController.location = location
        weatherDetailViewController.isMetric = isMetric
    }
}

extension MainWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 150, height: 300)
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
}

extension MainWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("percent encoding failed")
            return false
        }
        textField.resignFirstResponder()
        useSearchResultToSetupView(zipcodeIsValid: checkForValidZipcode(), keyword: keyword)
        return true
    }
}
