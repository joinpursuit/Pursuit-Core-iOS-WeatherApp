//
//  FavoritedImageModel.swift
//  WeatherApp
//
//  Created by Jane Zhu on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct FavoritesModel {
    static var favoritedImages = [Favorite]()
    static let filename = "Favorites.plist"
    
    static func getFavoritedImages() -> [Favorite] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    favoritedImages = try PropertyListDecoder().decode([Favorite].self, from: data)
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
    
    static func saveData() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(favoritedImages)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error at saveFavoritedImage - \(error)")
        }
    }
    
    static func addFavoriteImage(favoriteImage: Favorite) {
        favoritedImages.append(favoriteImage)
        saveData()
    }
    
}
