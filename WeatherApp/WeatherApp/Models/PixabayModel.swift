//
//  PixabayModel.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
final class PixabayModel {
    private static let filename = "SavedImageList.plist"
    private static var savedImages = [SavedImage]()
    private init() {}
    static func appendImage(image: SavedImage) {
        savedImages.append(image)
        saveImage()
    }
    static func saveImage() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        
        do {
            let data = try PropertyListEncoder().encode(savedImages)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoder: \(error)")
        }
    }
    static func getImage() -> [SavedImage] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    savedImages = try PropertyListDecoder().decode([SavedImage].self, from: data)
                } catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("getPhotoJournal - data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        savedImages = savedImages.sorted {$0.createdAt > $1.createdAt}
        
        return savedImages
    }


}
