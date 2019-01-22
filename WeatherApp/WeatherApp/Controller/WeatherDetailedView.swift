//
//  WeatherDetailedView.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailedView: UIViewController {

  public var receiveCityInfo: WeatherDetails?
  
  @IBOutlet weak var cityName: UILabel!
  
  @IBOutlet weak var cityImage: UIImageView!
  
  
  @IBOutlet weak var moreInfo: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      UISetup()
    }
  
  private func UISetup() {
    
    if let additionInfo = receiveCityInfo {
      moreInfo.text = """

      High: \(additionInfo.maxTempC)
      Low: \(additionInfo.minTempC)
      Sunrise: \(additionInfo.sunriseISO)
      Sunset: \(additionInfo.sunsetISO)
      Inches of Precipitation: \(additionInfo.precipIN)

      """
    }
    
    //high
    //low
    //sunrise
    //sunset
    //windspeed
    //inches of precipitation
    
  }
  

  
  
}
