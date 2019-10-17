//
//  SavedPicPersistance.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
//struct ImageHolder: Codable {
//    let imageData: Data
//}

class SavedPicPersistance {
    private init() {}
    static let manager = SavedPicPersistance()
    
    func save(pictureData: Data) throws {
        try persistanceHelper.save(newElement: pictureData)
        print("saved")
    }
    func getPictures() throws -> [Data] {
        return try persistanceHelper.getObjects()
    }
    
    private let persistanceHelper = PersistenceHelper<Data>(fileName: "SavedPic.plist")
}
