//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var weather = [WeatherInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    var location = String()
    var textfieldText = "Enter a ZipCode..."
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainLocationLabel: UILabel!
    @IBOutlet weak var mainZipCodeTextField: UITextField!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextField()
    mainCollectionView.dataSource = self
  }
    func setupTextField() {
        mainZipCodeTextField.delegate = self
        mainZipCodeTextField.text = textfieldText
        mainZipCodeTextField.textColor = .lightGray
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! UICollectionViewCell
            let indexPaths = self.mainCollectionView.indexPath(for: cell)
            detailVC.weatherDetail = weather[indexPaths!.row]
            detailVC.locationName = self.location
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return weather.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        let weatherToSet = weather[indexPath.row]
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 20
        cell.mainCellImage.image = UIImage(named: weatherToSet.icon)
        cell.mainCellDate.text = WeatherDateHelper.formatISOToDate(dateString: weatherToSet.dateTimeISO)
        cell.mainCellHigh.text = "High: \(String(weatherToSet.maxTempF))℉"
        cell.mainCellLow.text = "Low: \(String(weatherToSet.minTempF))℉"
        return cell
    }
}
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = textField.text {
            ZipCodeHelper.getLocationName(from: keyword) { (error, string) in
                if let error = error {
                    print("Your code is trash bro \(error)")
                } else if let string = string {
                    self.location = string
                     self.mainLocationLabel.text = "Weather forcast for \(self.location)"
                    WeatherAPIClient.getWeather(keyword: keyword) { (error, data) in
                        if let error = error {
                            print("My code is trash bro \(error)")
                        } else if let data = data {
                            self.weather = data
                        }
                    }
                }
            }
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainZipCodeTextField.text = ""
        mainZipCodeTextField.textColor = .black
    }
}
