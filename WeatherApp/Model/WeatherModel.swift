//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Jose Alarcon Chacon on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
final class WeatherModel {
    private static let filename = "ToDoList.plist"
    private static var items = [ImageModel]()
    private init () {}
    static func getImage() -> [ImageModel]{
        let path = DataPresistenceManager.filePathToDocumentDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    items = try PropertyListDecoder().decode([ImageModel].self, from: data)
                } catch {
                     print("property list decoding error: \(error)")
                }
            } else {
                   print("data is nil")
            }
        } else {
             print("\(filename) does no exist")
        }
        items = items.sorted{$0.createdAt > $1.createdAt}
        return items
    }
    static func addItem(item: ImageModel) {
        items.append(item)
        save()
    }
    static func save() {
        let path = DataPresistenceManager.filePathToDocumentDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(items)
            try  data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
              print("property list encoding error : \(error)")
        }
    }
}

