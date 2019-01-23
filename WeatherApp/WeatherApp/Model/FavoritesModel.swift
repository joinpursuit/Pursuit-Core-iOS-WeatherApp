//
//  FavoritesModel.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct FavoritePhotos: Codable {
let createdAt: String
let imageData: Data
}

final class FavoriteCityPhotos {
  
  static let filename = "WeatherPhotoFavorites.plist"
  private static var photoItems = [FavoritePhotos]()
  
  private init() {}
  
  static func savePhoto() {
    let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename)
    print(path)
    do {
      let data = try PropertyListEncoder().encode(photoItems)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch {
      print("property list encoding error: \(error)")
    }
  }
  
  static func getPhotoJournal() -> [FavoritePhotos] {
    let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename).path
    if FileManager.default.fileExists(atPath: path){
      if let data = FileManager.default.contents(atPath: path) {
        do {
          photoItems = try PropertyListDecoder().decode([FavoritePhotos].self, from: data)
        } catch {
          print("property list decoding error: \(error)")
        }
      } else {
        print("getPhotoJournal: data in nil")
      }
    } else {
      print("\(filename) does not exist")
    }
    photoItems = photoItems.sorted { $0.createdAt > $1.createdAt }
    return photoItems
  }
  
  static func addIEntry(item: FavoritePhotos) {
    photoItems.append(item)
    savePhoto()
  }
  
  static func updateItem(updatedItem: FavoritePhotos, atIndex index: Int) {
    photoItems[index] = updatedItem
    savePhoto()
  }
  
  static func delete(atIndex index: Int) {
    photoItems.remove(at: index)
    savePhoto()
  }
}

