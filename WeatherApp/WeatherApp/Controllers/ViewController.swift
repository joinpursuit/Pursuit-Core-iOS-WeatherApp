//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "Forecast Cell")
        return collectionView
        
    }()
    
    private var zipcode: String = "11365"
    
    private var forecasts = [DailyDatum]() {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureView()
    }
    
    private func loadData() {
        if let zipcodeFromDefaults = UserDefaultsWrapper.helper.getZipcode() {
            zipcode = zipcodeFromDefaults
        }
        
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { result in
            switch result {
            case .success((let lat, let long, let placename)):
                DispatchQueue.main.async {
                    self.cityLabel.text = "Weather forecast for \(placename)"
                    self.getForecast(lat, long: long)
                }
                
            case .failure(let error):
                // TODO: Show Alert Controller
                print(error)
            }
        }
    }
    
    private func getForecast(_ lat: Double, long: Double) {
        let url = "https://api.darksky.net/forecast/\(APIKey.darkSkyKey)/\(lat),\(long)"
        
        GenericCoderAPI.manager.getJSON(objectType: Forecast.self, with: url) { result in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.forecasts = forecast.daily.data
                }
            case .failure(let error):
                // TODO: Show Alert Controller
                print(error)
            }
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemOrange
        setupCityLabel()
        setupCollectionView()
    }
    
    private func setupCityLabel() {
        view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)])
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Forecast Cell", for: indexPath) as? ForecastCollectionViewCell else {
            print("Error occured creating cell")
            return UICollectionViewCell()
        }
        cell.configureCell(forecast: forecasts[indexPath.row])
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2)
    }
}

