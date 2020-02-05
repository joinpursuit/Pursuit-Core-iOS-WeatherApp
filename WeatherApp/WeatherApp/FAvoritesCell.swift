//
//  FAvoritesCell.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import  ImageKit

class FAvoritesCell: UITableViewCell {

    @IBOutlet weak var cityImage: UIImageView!
    
    
    public func confugureCell(for faveimage: ImageObject) {
        cityImage.image = UIImage(data: faveimage.image)
    }
    
}
