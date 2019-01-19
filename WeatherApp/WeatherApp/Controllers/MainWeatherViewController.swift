//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var locationTextField: UITextField!
    
    private var dailyForecast = [DailyForecast]() {
        didSet {
            DispatchQueue.main.async {
                self.forecastCollectionView.reloadData()
            }
        }
    }

    fileprivate func getWeatherData() {
        AerisAPIClient.searchLocation(keyword: "11219", isZipcode: true) { (appError, dailyForecast) in
            if let appError = appError {
                print(appError)
            } else if let dailyForecast = dailyForecast {
                self.dailyForecast = dailyForecast
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        locationTextField.delegate = self
        
    }


}

extension MainWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 150, height: 265)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell
            else {
            print("unable to dequeue daycell")
            return UICollectionViewCell()
        }
        let dayToSet = dailyForecast[indexPath.row]
        cell.date.text = dayToSet.dateTimeISO
        cell.high.text = "High: " +  dayToSet.maxTempF.description + "° F"
        cell.low.text = "Low: " + dayToSet.minTempF.description + "° F"
        cell.weatherImage.image = UIImage(named: dayToSet.icon)
        return cell
    }
}

extension MainWeatherViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // need to fix this
        textField.resignFirstResponder()
    }
}
