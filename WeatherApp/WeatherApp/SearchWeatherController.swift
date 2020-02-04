//
//  SearchWeatherController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class SearchWeatherController: UIViewController {
    
    private let searchWeatherView = SearchWeatherView()
    
    var zipCode = ""
    
    public var dailyWeather = [DailyDatum]() {
      didSet {
        // 13.
          DispatchQueue.main.async {
              self.searchWeatherView.collectionView.reloadData()
          }
      }
    }
    
    override func loadView() {
        view = searchWeatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Weather Search"
        
        searchWeatherView.collectionView.dataSource = self
        searchWeatherView.collectionView.delegate = self
        searchWeatherView.collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "weatherCell")
        
        searchWeatherView.textField.delegate = self
        //fetchWeather(lat: , long: -122.4233)
        }
        
    private func fetchWeather(lat: Double, long: Double){
        WeatherAPIClient.fetchWeather(lat: lat, long: long) {(result) in
            switch result {
            case .failure(let appError):
                print("error fetching weather \(appError)")
            case .success(let weather):
                self.dailyWeather = weather.daily.data
            }
        }
    }
    
    private func getZipCode(zipCode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) {(result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let lat, let long):
                self.fetchWeather(lat: lat, long: long)
            }
    }
    }
}

extension SearchWeatherController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCellCollectionViewCell else {
            fatalError("could not downcast to WeatherCellCollectionViewCell")
        }
        let dayWeather = dailyWeather[indexPath.row]
        cell.backgroundColor = .white
        cell.configureCell(weather: dayWeather )
        return cell
    }
}

extension SearchWeatherController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.5
        return CGSize(width: itemWidth, height: 350)
    }
    
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let weatherData = dailyWeather[indexPath.row]
    
    let detailVC = DetailViewController ()
    detailVC.weather = weatherData
    navigationController?.pushViewController(detailVC, animated: true)
}
}

extension SearchWeatherController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipCode = textField.text ?? "11215"
        getZipCode(zipCode: zipCode)
       textField.resignFirstResponder()
        
    return true
    }
}
