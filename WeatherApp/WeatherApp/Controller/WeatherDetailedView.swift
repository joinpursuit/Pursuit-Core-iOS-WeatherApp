//
//  WeatherDetailedView.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailedView: UIViewController {
  
  var imageIndex: Int?
  
  public var receiveCityInfo: WeatherDetails?
  
  @IBOutlet weak var cityName: UILabel!
  
  @IBOutlet weak var cityImage: UIImageView!
  
  @IBOutlet weak var moreInfo: UILabel!
  
  public var nameOfCity = String()
  
  //TODO: My app crashes when it doesn't find pictures
  
  var imageData = [ImageDetailedInfo] () {
    didSet {
      DispatchQueue.main.async {
        let image = Int.random(in: 0..<self.imageData.count)
        ImageHelper.shared.fetchImage(urlString: self.imageData[image].largeImageURL) { (appError, image) in
          if let appError = appError {
            print(appError)
          }
          if let image = image {
            DispatchQueue.main.async {
              self.cityImage.image = image
            }
          }
        }
      }
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = nameOfCity
    UISetup()
  }
  
  private func UISetup() {
    
    if let additionInfo = receiveCityInfo {
      moreInfo.text = """
      
      High: \(additionInfo.maxTempC) °C
      Low: \(additionInfo.minTempC) °C
      Sunrise: \(additionInfo.sunriseFormattedString)
      Sunset: \(additionInfo.sunsetFormattedString)
      Inches of Precipitation: \(additionInfo.precipIN) inches.
      
      """
      
      cityName.text = "The weather in \(nameOfCity) is \(additionInfo.weather)"
    }
    
    
    ImagesClientAPI.searchImage(selectedCityName: nameOfCity.lowercased()) { (appError, images) in
      if let appError = appError {
        print(appError)
      }
      if let data = images {
        self.imageData = data
        dump(self.imageData)
      }
    }
  }
  
  
  @IBAction func savePhoto(_ sender: Any) {
    guard let photo = cityImage.image else {return}
    let date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
    let timestamp = isoDateFormatter.string(from: date)
    if let imageData = photo.jpegData(compressionQuality: 0.5) {
      
      let photoItemToSave = FavoritePhotos.init(createdAt:timestamp, imageData: imageData)
    
        FavoriteCityPhotos.addIEntry(item: photoItemToSave)

    }
    dismiss(animated: true, completion: nil)
  }
  
}

