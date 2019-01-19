//
//  FavoritedImageModel.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct FavoritedImageModel {
    static var favoritedImages = [FavoritedImage]()
    static let filename = "Favorites.plist"
    
    static func getFavoritedImages() -> [FavoritedImage] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    favoritedImages = try PropertyListDecoder().decode([FavoritedImage].self, from: data)
                } catch {
                    print("property list decoding error = getFavoritedImages() \(error)")
                }
            } else {
                print("getFavoritedImages - data at \(filename) is nil")
            }
        } else {
            print("\(filename) plist does not exist")
        }
        favoritedImages = favoritedImages.sorted{ $0.date > $1.date }
        return favoritedImages
    }
    
}
