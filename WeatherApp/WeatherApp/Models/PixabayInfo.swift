//
//  PixabayModel.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct PixabayInfo: Codable{
    let totalHits: Int
    let hits: [Hits]
}
struct Hits: Codable {
    let largeImageURL: String
//    "webformatHeight": 426,
//    "webformatWidth": 640,
//    "likes": 619,
//    "imageWidth": 3000,
//    "id": 336475,
//    "user_id": 242387,
//    "views": 190372,
//    "comments": 93,
//    "pageURL": "https://pixabay.com/en/new-york-city-brooklyn-bridge-night-336475/",
//    "imageHeight": 2000,
//    "webformatURL": "https://pixabay.com/get/ea36b70b2ff11c22d2524518b74d4795e570e0d41eac104491f8c379a5e8bdb9_640.jpg",
//    "type": "photo",
//    "previewHeight": 99,
//    "tags": "new york city, brooklyn bridge, night",
//    "downloads": 77167,
//    "user": "Free-Photos",
//    "favorites": 568,
//    "imageSize": 1230835,
//    "previewWidth": 150,
//    "userImageURL": "https://cdn.pixabay.com/user/2014/05/07/00-10-34-2_250x250.jpg",
    let previewURL: String

}
