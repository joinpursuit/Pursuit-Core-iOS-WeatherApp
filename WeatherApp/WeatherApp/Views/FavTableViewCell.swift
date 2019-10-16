//
//  FavTableViewCell.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    var favImage: UIImageView = {
        var image = UIImageView()
        var frame = image.frame.size
        frame.width = UIScreen.main.bounds.width
        frame.height = frame.width
        image.frame.size = frame
        return image
    }()
    func setupImage() {
        contentView.addSubview(favImage)
        favImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            favImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        favImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        favImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
