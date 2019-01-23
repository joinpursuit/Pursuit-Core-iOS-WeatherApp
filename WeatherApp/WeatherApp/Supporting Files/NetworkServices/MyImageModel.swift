//
//  ImageModel.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class SavedImageModel {
    private static let filename = "FavoritedImages.plist"
    
    private static var savedImages = [SavedImage]()
    static func saveImage(){
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(savedImages)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch{
            print("error encountered while encoding data")
        }
    }
    
    static func save(image:SavedImage){
        savedImages.append(image)
        saveImage()
    }
    
    static func getSavedImages() -> [SavedImage]{
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path){
            
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    savedImages = try PropertyListDecoder().decode([SavedImage].self, from: data)
                } catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("Data is nil")
            }
            
            
        } else {
            print("\(filename) does not exist")
        }
        
       
        
        return savedImages
        
    }
    
    
    
    
}


