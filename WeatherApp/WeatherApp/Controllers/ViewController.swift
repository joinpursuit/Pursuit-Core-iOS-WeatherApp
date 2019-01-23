//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var forecastCity: UILabel!
    @IBOutlet weak var weatherCV: UICollectionView!
    @IBOutlet weak var searchButton: UITextField!
    
    public var forecast = [Periods](){
        didSet {
            DispatchQueue.main.async {
                self.weatherCV.reloadData()
            }
        }
    }
    private var imagePickerVC: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCV.dataSource = self
        weatherCV.delegate = self
        print(DataPersistenceManager.documentsDirectory())
        
        WeatherAPIClient.searchWeather(zipcode: "11229", isZipcode: true) { (appError, periods) in
            if let error = appError {
                print(error.errorMessage())
            }
            if let periods = periods {
                self.forecast = periods
                dump(self.forecast)
            }
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        weatherCV.reloadData()
//    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        present(vc, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? WeatherDetailViewController
            else { return }
       guard let cell = sender as? WeatherCollectionViewCell
        else { return }
        guard let indexpath = weatherCV.indexPath(for: cell) else{return}
        let forecast = self.forecast[indexpath.row]
        destination.dayInfo = forecast
        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCV.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell()}
 var day = forecast[indexPath.row]
        cell.dayLabel.text = "\(day.validTime)"
        cell.imageSet.image = UIImage(named: day.icon)
        cell.highLabel.text = "High:\(day.maxTempF) °F"
        cell.lowLabel.text = "Low:\(day.minTempF) °F"
        
        
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: weatherCV.frame.width, height: weatherCV.frame.height)
    }
}
