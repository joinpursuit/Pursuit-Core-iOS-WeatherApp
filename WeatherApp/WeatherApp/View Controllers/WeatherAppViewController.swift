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
    @IBOutlet weak var weatherImage: UIImageView!
    var city = ""
    var zipCode = "10453" {
        didSet {
            DispatchQueue.main.async {
                self.getData()
                self.weatherAppCollectionView.reloadData()
            }
        }
    }
    

    
    
    var weatherInformation = [PeriodsInformation](){
        didSet {
            DispatchQueue.main.async {
                self.weatherAppCollectionView.reloadData()
            }
        }
    }
    public var isZipcode = true
    
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherAppCollectionView.dataSource = self
    weatherAppCollectionView.delegate = self
    inputZipCode.delegate = self
    getData()
    setCityName()
    weatherImage.image = UIImage.init(named: "morning")
  }
    
    
    
    
    
    func setCityName(){
        ZipCodeHelper.getLocationName(from: zipCode) { (error, data) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                self.city = data
                self.cityName.text = "Weather forecast for \(data)"
                
            }
        }
    }
    
    
    func getData(){
       
        WeatherAPIClient.weatherInformation(zipCode: zipCode) { (error, data) in
            if let error = error {
                print("Error: \(error)")
            } else if let weather = data {
                self.weatherInformation = weather.response[0].periods
                print(self.weatherInformation.count)
                self.setCityName()
            }
        }
        
        
    }

}
extension WeatherAppViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherAppCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        let dayToSet = weatherInformation[indexPath.row]
     
        cell.day.text = dayToSet.dateFormattedString
        cell.high.text = "High: \(dayToSet.maxTempF) F"
        cell.low.text = "Low: \(dayToSet.minTempF) F"
        cell.weatherImage.image = UIImage.init(named: dayToSet.images)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let weatherDetailViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailVC") as? WeatherDetailedViewController else {return}
        weatherDetailViewController.modalPresentationStyle = .currentContext
        weatherDetailViewController.weatherDetails = weatherInformation[indexPath.row]
        weatherDetailViewController.cityName = city
        
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
    
    
}
extension WeatherAppViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let zip = textField.text {
            
            isZipcode = true
            for char in zip {
                if Int(String(char)) == nil {
                    isZipcode = false
                    break
                }
            }
            if isZipcode {
                zipCode = zip
               
            }
    }
        return true
        
    
}


}
