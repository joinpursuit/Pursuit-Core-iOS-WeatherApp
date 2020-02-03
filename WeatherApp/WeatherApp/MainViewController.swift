//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var weather: Weather?
    
    private var dailyWeather = [DailyDatum]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var zipCode = "11221"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = weather?.timezone
        collectionView.delegate = self
        collectionView.dataSource = self
        zipCodeTextField.delegate = self
        getWeather(lat: 37.8267, long: -122.4233)
       //
    }
    
    private func getWeather(lat: Double, long: Double) {
        WeatherAPIClient.fetchWeather(for: lat, long: long) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let weather):
                self.dailyWeather = weather.daily.data
            }
        }
    }
    
    private func getCityWeather(zipCode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let lat, let long):
                self.getWeather(lat: lat, long: long)
            }
        }
    }


}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCell else {
            fatalError("could not downcast to weather cell")
        }
        let dayWeather = dailyWeather[indexPath.row]
        cell.configureCell(weather: dayWeather)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // width of the device
    let maxWidth: CGFloat = UIScreen.main.bounds.size.width
    // cell width is 80% of device width
    let itemWidth: CGFloat = maxWidth * 0.80
    return CGSize(width: itemWidth, height: itemWidth)
        
    }
    
}
// call ZipCode helper in the delegate method for text field textfieldshouldreturn
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipCode = textField.text ?? "11221"
        getCityWeather(zipCode: zipCode)
        //locationLabel.text = weather?.timezone
        return true
    }
}
