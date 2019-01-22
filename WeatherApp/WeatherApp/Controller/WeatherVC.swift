//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var zipCodeEntry: UITextField!
    
    var weather = [WeatherInfo](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        collectionView.dataSource = self
        collectionView.delegate = self
        dump(weather)
    }
    
    private func loadData() {
        APIClient.getForecasts(keyword: "11101") { (error, weather) in
            if let error = error {
                print(error)
            } else if let weather = weather {
                self.weather = weather
            }
        }
    }
    
}
extension WeatherVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 400, height: 400)
    }
}
extension WeatherVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {return UICollectionViewCell()}
        
        let weatherDetailIExpect = weather[indexPath.row]
        cell.date.text = weatherDetailIExpect.dateTimeISO
        if let high = weatherDetailIExpect.maxTempF {
            cell.high.text = "High:\(high)"
        }
        if let low = weatherDetailIExpect.minTempF {
            cell.low.text = "Low:\(low)"
        }
        cell.photo.image = UIImage(named: weatherDetailIExpect.icon)
        return cell
    }
}
