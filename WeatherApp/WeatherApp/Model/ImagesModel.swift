//
//  ImagesModel.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ImageModel: Codable {
  let hits: [ImageDetailedInfo]
}

struct ImageDetailedInfo: Codable {
  let largeImageURL: String //URL
  let id: Int
}
