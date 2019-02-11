//
//  Favorite .swift
//  WeatherApp
//
//  Created by Manny Yusuf on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ImagesData: Codable {
    let hits: [Images]
}

struct Images: Codable {
    let largeImageURL: String
}
