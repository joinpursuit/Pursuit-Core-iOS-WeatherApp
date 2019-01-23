//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    
    private var temperatures = [Temperature]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    public var trueZipcode = true
    public var myZipcode = "10462"
    public var location = ""
    public var metricUS = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(DataPersistenceManager.documentsDirectory())
        checkForDefaultSearchSettings()
        collectionView.dataSource = self
        collectionView.delegate = self
        textField.delegate = self
        updateRightButtonItem(keyword: "US")
  }
    func actionSheet() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let  metricAction = UIAlertAction(title: "Metric", style: .default, handler: { (action) -> Void in
            print("Metric")
            self.metricUS = true
        })
        let usAction = UIAlertAction(title: "US", style: .default, handler: { (action) -> Void in
            print("US")
            self.metricUS = false
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(metricAction)
        optionMenu.addAction(usAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    private func updateRightButtonItem(keyword: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: keyword, style: .plain, target: self, action: #selector(updateSettings))
    }
    @objc func updateSettings() {
        actionSheet()
    }
    private func checkForDefaultSearchSettings() {
        var zipcodeToSearch = ""
        if let searchWord = UserDefaults.standard.object(forKey: "Location") as? String {
            zipcodeToSearch = searchWord
        } else {
            zipcodeToSearch = myZipcode
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
        textField.text = zipcode
        searchZipcode(fromZipcode: zipcode)
    }
    
    private func checktrueZipcode() -> Bool {
        if var keyword = textField.text {
            if keyword == "" {
                keyword = myZipcode
                trueZipcode = true
            } else {
                trueZipcode = true
                guard let intText = Int(textField.text!) else {return false}
                if intText >= 00501 && intText <= 99950 {
                    trueZipcode = true
                } else {
                    trueZipcode = false
                }
            }
        }
        return trueZipcode
    }
    private func searchZipcode(fromZipcode: String) {
        WeatherAPIClient.searchZipcode(zipcode: fromZipcode, isZipcode: trueZipcode) { (appError, temperatures) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let temperatures = temperatures {
                self.temperatures = temperatures[temperatures.count-1].periods
            }
        }
    }
    private func useSearchResultToSetupView(zipcodeIsValid: Bool, keyword: String) {
        if zipcodeIsValid {
            searchZipcode(fromZipcode: keyword)
            UserDefaults.standard.set(keyword, forKey: "Location")
            setupView(zipcode: keyword)
        } else {
            print("hello")
        }
    }

}
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temperatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell()}
        let temperature = temperatures[indexPath.row]
        cell.dateLabel.text = temperature.dateTimeISO.formatFromISODateString(dateFormat: "yyyy-MM-d")
        
        
        let iconName = temperature.icon.replacingOccurrences(of: ".png", with: "")
        cell.weatherImage.image = UIImage(named: iconName)
        
        if metricUS == false {
            cell.highLabel.text = "High: \(temperature.maxTempF)°F"
            cell.lowLabel.text = "Low: \(temperature.minTempF)°F"
        } else {
            cell.highLabel.text = "High: \(temperature.maxTempC)°C"
            cell.lowLabel.text = "Low: \(temperature.minTempC)°C"
        }
        return cell
    }
}
extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController else { return }
        destinationViewController.dayWeather = temperatures[indexPath.row]
        destinationViewController.location = self.location
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("percent encoding failed")
            return false
        }
        textField.resignFirstResponder()
        useSearchResultToSetupView(zipcodeIsValid: checktrueZipcode(), keyword: keyword)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")

        if (isBackSpace == -92) {
            return true
        }
        let characterSetAllowed = CharacterSet(charactersIn: "0123456789")

        return textField.text!.count < 5 && (string.rangeOfCharacter(from: characterSetAllowed, options: .caseInsensitive) != nil)
    }
}
