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
    @IBOutlet weak var zipCode: UILabel!
    
    
    
    
    var selectedCityForPhoto = "New York"
    
    var weathers = [WeatherInfo](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        zipCodeEntry.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        zipCode.text = "New York"
    }
    
    private func loadData() {
        APIClient.getForecasts(keyword: "11106") { (error, weather) in
            if let error = error {
                print(error)
            } else if let weather = weather {
                self.weathers = weather
            }
        }
    }
}
extension WeatherVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 250, height: 250)
    }
}

extension WeatherVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {return UICollectionViewCell()}
        
        let weatherDetailIExpect = weathers[indexPath.row]
        cell.date.text = "\(weatherDetailIExpect.dateTimeISO)"
        if let high = weatherDetailIExpect.maxTempF {
            cell.high.text = "High:\(high)"
        }
        if let low = weatherDetailIExpect.minTempF {
            cell.low.text = "Low:\(low)"
        }
        cell.photo.image = UIImage(named: weatherDetailIExpect.icon)
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DetailVC = storyboard.instantiateViewController(withIdentifier: "WeatherDetailVC") as! WeatherDetailVC
        DetailVC.weather = weathers[indexPath.row]
        DetailVC.city = selectedCityForPhoto
        DetailVC.modalTransitionStyle = .crossDissolve
        DetailVC.modalPresentationStyle = .overCurrentContext
        self.present(DetailVC, animated: true, completion: nil)
    }
}
extension WeatherVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            ZipCodeHelper.getLocationName(from: text) { (error, city) in
                if let error = error {
                    print(error)
                    let alert = UIAlertController(title: "No Location Found", message: nil, preferredStyle: .alert)
                    let okayButton = UIAlertAction.init(title: "Okay", style: .default, handler: { (UIAlertAction) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alert.addAction(okayButton)
                    self.present(alert, animated: true, completion: nil)
                } else if let city = city {
                    self.selectedCityForPhoto = city
                    self.zipCode.text = city
                    APIClient.getForecasts(keyword: text) { (error, weather) in
                        if let error = error {
                            print(error)
                        } else if let weather = weather {
                            self.weathers = weather
                        }
                    }
                }
            }
            
        }

        return true
    }
}

