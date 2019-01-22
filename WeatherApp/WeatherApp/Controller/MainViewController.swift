//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var weather = [WeatherInfo] () {
        didSet {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    let zipcode = "11204"
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainLocationLabel: UILabel!
    @IBOutlet weak var mainZipCodeTextField: UITextField!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    WeatherAPIClient.getWeather(keyword: zipcode) { (error, data) in
        if let error = error {
            print("My code is trash bro \(error)")
        } else if let data = data {
            self.weather = data
        }
    }
    mainCollectionView.dataSource = self
    mainCollectionView.delegate = self
  }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        let weatherToSet = weather[indexPath.row]
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 20
        cell.mainCellImage.image = UIImage(named: weatherToSet.icon)
        cell.mainCellHigh.text = "High: \(String(weatherToSet.maxTempF))"
        cell.mainCellLow.text = "Low: \(String(weatherToSet.minTempF))"
        return cell
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        vc.weather = weather[indexPath.row]
        
    }
}
