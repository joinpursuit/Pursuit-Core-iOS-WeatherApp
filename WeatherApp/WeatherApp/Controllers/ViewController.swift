//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forcast for "
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var weatherCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 200), collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(ForcastCell.self, forCellWithReuseIdentifier: "forcastCell")
        collection.backgroundColor = .gray
        return collection
    }()
    
    private func setupUI() {
        setupWeatherLabel()
        setupWeatherCollectionView()
    }
    private func setupWeatherLabel() {
        view.addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            weatherLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
    }
    private func setupWeatherCollectionView() {
        view.addSubview(weatherCollectionView)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor,constant: 10),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: weatherCollectionView.frame.height),
            weatherCollectionView.widthAnchor.constraint(equalToConstant: weatherCollectionView.frame.width)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }


}

