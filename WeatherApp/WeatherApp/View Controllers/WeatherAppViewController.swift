//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherAppViewController: UIViewController {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherAppCollectionView: UICollectionView!
    @IBOutlet weak var inputZipCode: UITextField!
    @IBOutlet weak var instructionsLabel: UILabel!
    var city = ""
    
    var weatherInformation = [WeatherFocasts](){
        didSet {
            DispatchQueue.main.async {
                self.weatherAppCollectionView.reloadData()
            }
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherAppCollectionView.dataSource = self
    weatherAppCollectionView.delegate = self
    getData()
  }
    
    
    func getData(){
        guard let zipCode = inputZipCode.text else {return}
        
        WeatherAPIClient.weatherInformation(zipCode: zipCode) { (error, data) in
            if let error = error {
                print("Error: \(error)")
            } else if let weather = data {
                self.weatherInformation = weather.response
            }
        }
    }
    
    func segue(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let weatherDetailViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailVC") as? WeatherDetailedViewController else {return}
        present(weatherDetailViewController, animated: true, completion: nil)
        
    }

}
extension WeatherAppViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherAppCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        let dayToSet = weatherInformation[indexPath.row]
     
        cell.day.text = dayToSet.periods[indexPath.row].validTime
        cell.high.text = "High: \(dayToSet.periods[indexPath.row].maxTempF)"
        cell.low.text = "Low: \(dayToSet.periods[indexPath.row].minTempF)"
        
        
        
        cityName.text = "Weather Forecast for \(city)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        segue()
    }
    
    
}


