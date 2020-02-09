//
//  SearchWeatherController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class SearchWeatherController: UIViewController {
    
    private let searchWeatherView = SearchWeatherView()
    
    public var dataPersistance: DataPersistence<Hit>!
    
    var weather: Weather?
    
    public var dailyWeather = [DailyDatum]() {
        didSet {
            DispatchQueue.main.async {
                self.searchWeatherView.collectionView.reloadData()
            }
        }
    }
    
    lazy var timezone = weather?.timezone
    lazy var cityFromLocation = timezone?.split(separator: "/")
    
    private var photo = [Hit]()
    
    private var zipcode = String() {
        didSet {
            getCoordinates(zipCode: zipcode)
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
        
        if let userzipcode = UserPreference.shared.getUserZipcode() {
            getCoordinates(zipCode: userzipcode)
        } else {
            getCoordinates(zipCode: zipcode)
        }
    }
    
    private func fetchWeather(lat: Double, long: Double){
        WeatherAPIClient.fetchWeather(lat: lat, long: long) {(result) in
            switch result {
            case .failure(let appError):
                print("error fetching weather \(appError)")
            case .success(let weather):
                self.weather = weather
                self.dailyWeather = weather.daily.data
            }
        }
    }
    
    private func getCoordinates(zipCode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) {[weak self](result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let coordinates):
                self?.fetchWeather(lat: coordinates.lat, long: coordinates.long)
                DispatchQueue.main.async {
                    self?.searchWeatherView.messageLabel.text = """
                    Weather Forecast For \(coordinates.placeName)
                    """
                    self?.loadPhotoData(photo: coordinates.placeName)
                }
            }
        }
    }
    
    public func loadPhotoData(photo: String) {
        PictureSearchAPIClient.fetchPicture(for: photo) {[weak self] (result) in
            switch result {
            case .failure:
                print("could not fetch pictures")
            case .success(let picture):
                self?.photo = picture
            }
            
        }
    }
//    func updateUI() {
//        searchWeatherView.messageLabel.text = """
//        Weather Forecast For \()
//        """
//    }
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
        detailVC.dailyWeather = weatherData
        detailVC.picture = photo[indexPath.row]
        detailVC.weather = weather
        detailVC.dataPersistance = dataPersistance
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchWeatherController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        zipcode = textField.text ?? "11215"
        UserPreference.shared.updateUserZipcode(with: zipcode)
        
        textField.text = ""
        return true
    }
}
