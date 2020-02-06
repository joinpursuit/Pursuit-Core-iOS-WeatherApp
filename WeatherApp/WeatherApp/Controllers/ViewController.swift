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
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter zipcode..."
        tf.backgroundColor = .systemBackground
        tf.borderStyle = .bezel
        return tf
    }()
    
    private var zipcode: String = "11365"
    private var place: String = "" {
        didSet {
            self.cityLabel.text = "Weather forecast for \(place)"
        }
    }
    
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
                    self.place = placename
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
        setupTextField()
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
    
    private func setupTextField() {
        textField.delegate = self
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: view.frame.width / 3)])
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecast = forecasts[indexPath.row]
        navigationController?.pushViewController(DetailViewController(forecast, placename: place), animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text.count == 5 {
            UserDefaultsWrapper.helper.store(zipcode: text)
            loadData()
        }
        textField.resignFirstResponder()
        return true
    }
}
