//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {

    public lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sunrise")
        return image
    }()
    

}
