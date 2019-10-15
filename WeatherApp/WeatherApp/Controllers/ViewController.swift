//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var weatherArray = [DataWrapper]() {
        didSet {
            self.weatherCollectionView.reloadData()
        }
    }

    var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forcast for "
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    lazy var weatherCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 140), collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.register(ForcastCell.self, forCellWithReuseIdentifier: "forcastCell")
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = CGSize(width: 200, height: 200)
        }
        collection.backgroundColor = #colorLiteral(red: 0.6798086851, green: 0.9229053351, blue: 0.9803921569, alpha: 1)
        return collection
    }()
    
    //MARK: - Functions
    private func loadData() {
        ZipCodeHelper.getLatLongName(fromZipCode: "11102") { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let info):
                WeatherAPIHelper.manager.getDailyWeather(info: (lat: info.lat, long: info.long)) { (resultFromAPI) in
                    switch resultFromAPI {
                    case .failure(let error):
                        print(error)
                    case .success(let dailyForcast):
                        DispatchQueue.main.async {
                            self.weatherArray = dailyForcast
                            dump(self.weatherArray)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Setup Constraints
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadData()
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forcastCell", for: indexPath) as? ForcastCell else {
            return UICollectionViewCell()
        }
        let dailyWeather = weatherArray[indexPath.row]
        cell.highLabel.text = "High: \(dailyWeather.temperatureHigh)"
        cell.lowLabel.text = "Low: \(dailyWeather.temperatureLow)"
        cell.weatherImage.image = getImageFrom(forcast: dailyWeather.icon)
        cell.dateLabel.text = "date"
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
