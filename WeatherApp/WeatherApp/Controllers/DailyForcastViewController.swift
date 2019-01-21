//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DailyForcastViewController: UIViewController {

    @IBOutlet weak var CollectionTableView: UICollectionView!
   
    private var weatherInfo = [daysOfTheWeek](){
        didSet {
            DispatchQueue.main.async {
     self.CollectionTableView.reloadData()
            }
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    CollectionTableView.dataSource = self
    CollectionTableView.delegate = self
    myWeather(state: "10021")
    dump(weatherInfo)
  }
    private func myWeather(state:String){
        WeatherApiClient.WeatherSearch(zipCode:state) { (appError, eachDay) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let eachDay = eachDay {
                self.weatherInfo = eachDay
                dump(self.weatherInfo)
            }
        }
    }

    
}
extension DailyForcastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 175)
    }
    
}
extension DailyForcastViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewcell = CollectionTableView.dequeueReusableCell(withReuseIdentifier: "WeatherInfo", for: indexPath) as? DailyCollectionViewCell else {return UICollectionViewCell()}
        let cellInfo = weatherInfo[indexPath.row].periods
        collectionViewcell.DateLabel.text = cellInfo?[indexPath.row].dateTimeISO
        collectionViewcell.forcastLabel.text = cellInfo?[indexPath.row].weather
        collectionViewcell.forcastImage.image = UIImage.init(named: "clear")
        return collectionViewcell
    }
    
    
}
