//
//  WeatherDetailVC.swift
//  WeatherApp
//
//  Created by Joshua Viera on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var DetailPhoto: UIImageView!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var inchesOfParticipation: UILabel!

    var weather: WeatherInfo!
    var city: String!
    var imageData =  [Images.HitWrapper](){
        didSet {
            let randomNumber = Int.random(in: 0...imageData.count - 1)
            ImageHelper.fetchImage(url: imageData[randomNumber].largeImageURL) { (error, image) in
                if let error = error {
                    print(error)
                }
                if let image = image {
                    DispatchQueue.main.async {
                    self.DetailPhoto.image = image
        
                    }
                    
                } else {
                    if let image = UIImage(named: self.weather.icon){
                    self.DetailPhoto.image = image
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        print(city)
    }
    
    func setUpLabels() {
        weatherCondition.text = DateHelper.getDate(date: weather.dateTimeISO)
        
        sunset.text = DateHelper.getTime(time: weather.sunsetISO)
        
        sunrise.text = DateHelper.getTime(time: weather.sunriseISO)

        if let rain = weather.percipIN{
            inchesOfParticipation.text = "Percipretation:\(rain)"
        }else {
            inchesOfParticipation.text = ""
        }
       
        windSpeed.text = "WindSpeed:\(weather.windSpeedMaxMPH)"
        if let highText = weather.maxTempF {
            high.text = "High:\(highText)"
        }
        if let lowText = weather.minTempF{
            low.text = "Low:\(lowText)"
        }
        
        APIClient.getPhotos(keyword: city) { (error, images) in
            if let error = error {
                print(error)
            } else if let images = images {
               self.imageData = images
            }
        }
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func FavoriteButton(_ sender: UIButton) {
        if let image = DetailPhoto.image {
            let dataFormatter = DateFormatter()
            dataFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = dataFormatter.string(from: Date())
            let favoritedAt = DateHelper.getDate(date: now)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {fatalError("No Image Data")}
            
            let favoriteImage = Favorites.init(createdAt: favoritedAt, imageData: imageData)
            PersistenceModel.addItem(favorite: favoriteImage)
        }
    }
    
}
