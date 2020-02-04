//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var dataPersistance:DataPersistence<Weather>?
    
    var weather: Weather?{
        didSet{
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
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
       // locationLabel.text = weather?.timezone
        collectionView.delegate = self
        collectionView.dataSource = self
        zipCodeTextField.delegate = self

        if let zipcodeUser = UserPreference.shared.getZipcode(){
            getCityWeather(zipCode: zipcodeUser)
        } else {
            getCityWeather(zipCode: zipCode)
        }
       // getWeather(lat: 37.8267, long: -122.4233)
        
       //
    }
    
   
    
    private func getWeather(lat: Double, long: Double) {
        WeatherAPIClient.fetchWeather(for: lat, long: long) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let weather):
                self.weather = weather
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

    private func updateUI() {
        locationLabel.text = weather?.timezone
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let localWeather = dailyWeather[indexPath.row]
       // let location = weather
        let detailVC = DetailViewController()
        detailVC.weather = localWeather
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
// call ZipCode helper. in the delegate method for text field textfieldshouldreturn
extension MainViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        zipCode = textField.text ?? "11221"
        getCityWeather(zipCode: zipCode)
        UserPreference.shared.updateZipcode(with: zipCode)
        

        //locationLabel.text = weather?.timezone
        return true
    }
    
}
