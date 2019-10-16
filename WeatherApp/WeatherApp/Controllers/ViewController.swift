//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var weatherArray = [DataWrapper]() {
        didSet {
            self.weatherCollectionView.reloadData()
        }
    }
    var name: String?
    var zipSearch: String? = nil {
        didSet {
            guard let text = zipSearch else {return}
            guard text != "" else {return}
            loadData(search: text)
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
    lazy var zipTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Zip Code"
        textField.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textField.keyboardType = .numbersAndPunctuation
        textField.delegate = self
        return textField
    }()
    
    var enterZipLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Enter a Zipcode"
        return label
    }()
    
    //MARK: - Functions
    private func loadData(search: String) {
        ZipCodeHelper.getLatLongName(fromZipCode: search) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let info):
                self.weatherLabel.text = "Weather Forcast for \(info.name)"
                self.name = info.name
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
    private func setUserDefaults() {
        if let pastSearch = UserDefaultWrapper.manager.getZipCode() {
            zipTextField.text = pastSearch
            loadData(search: pastSearch)
        }
    }
    
    //MARK: - Setup Constraints
    private func setupUI() {
        setupWeatherLabel()
        setupWeatherCollectionView()
        setupZipTextField()
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
    private func setupZipTextField() {
        view.addSubview(zipTextField)
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zipTextField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 30),
            zipTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        setupZipCodeLabel()
        zipTextField.widthAnchor.constraint(equalTo: enterZipLabel.widthAnchor).isActive = true
    }
    private func setupZipCodeLabel() {
        view.addSubview(enterZipLabel)
        enterZipLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterZipLabel.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20),
            enterZipLabel.centerXAnchor.constraint(equalTo: zipTextField.centerXAnchor)])
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setUserDefaults()
    }
}

//MARK: - Extension - CollectionView
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forcastCell", for: indexPath) as? ForcastCell else {
            return UICollectionViewCell()
        }
        let dailyWeather = weatherArray[indexPath.row]
        cell.highLabel.text = "High: \(dailyWeather.temperatureHigh)\u{00B0}F"
        cell.lowLabel.text = "Low: \(dailyWeather.temperatureLow)\u{00B0}F"
        cell.weatherImage.image = getImageFrom(forcast: dailyWeather.icon)
        cell.dateLabel.text = dailyWeather.convertTimeToDate(time: dailyWeather.time)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dailyWeather = weatherArray[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.dailyWeather = dailyWeather
        detailVC.name = name
        self.navigationController?.pushViewController(detailVC, animated: true)
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
//MARK: - Extention - TextField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipSearch = textField.text
        if let zipSearch = zipSearch {
            UserDefaultWrapper.manager.set(value: zipSearch)
        }
        return true
    }
}
