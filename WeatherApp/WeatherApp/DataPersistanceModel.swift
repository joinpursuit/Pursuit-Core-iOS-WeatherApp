//
//  DataPersistanceModel.swift
//  WeatherApp
//
//  Created by Leandro Wauters on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct DataPersistanceModel {
    private static var images = [FavoriteImage]()
    private static let filename = "CityImages.plist"
    private init () {}
    
    static func save(){
        let path = DataPersistanceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(images)
            try data.write(to: path, options: .atomic)
        } catch {
            print("Property list encoding error \(error)")
        }
    }
    static func favoriteImage(image: FavoriteImage){
        images.append(image)
        save()
    }
    static func getImages() -> [FavoriteImage]{
        let path = DataPersistanceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path){
                do {
                    images = try PropertyListDecoder().decode([FavoriteImage].self, from: data)
                    images = images.sorted{$0.date > $1.date}
                }catch{
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("getPhotoJournal data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return images
    }
    
}

