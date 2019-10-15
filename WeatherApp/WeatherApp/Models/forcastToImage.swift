//
//  forcastToImage.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/14/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import UIKit

func getImageFrom(forcast: String) -> UIImage {
    switch forcast {
    case "clear-day":
        return #imageLiteral(resourceName: "sunny")
    case "clear-night":
        return #imageLiteral(resourceName: "sunnyn")
    case "rain":
        return #imageLiteral(resourceName: "rainn")
    case "snow":
        return #imageLiteral(resourceName: "snow")
    case "sleet":
        return #imageLiteral(resourceName: "rainandsnown")
    case "wind":
        return #imageLiteral(resourceName: "wind")
    case "fog":
        return #imageLiteral(resourceName: "fogn")
    case "cloudy":
        return #imageLiteral(resourceName: "cloudyn")
    case "partly-cloudy-day":
        return #imageLiteral(resourceName: "pcloudy")
    case "partly-cloudy-night":
        return #imageLiteral(resourceName: "pcloudyn")
    case "hail":
        return #imageLiteral(resourceName: "sleetn")
    case "thunderstorm":
        return #imageLiteral(resourceName: "tstormn")
    case "tornado":
        return #imageLiteral(resourceName: "tstormwn")
    default:
        return #imageLiteral(resourceName: "fair")
    }
}
