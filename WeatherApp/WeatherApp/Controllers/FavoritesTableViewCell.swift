//
//  FavoritesTableViewCell.swift
//  WeatherApp
//
//  Created by Ahad Islam on 2/6/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    private lazy var cityView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCityView()
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
    
    public func configureCell(_ imageObject: ImageObject) {
        guard let image = UIImage(data: imageObject.imageData) else {
            print("bad image")
            return
        }
        
        cityView.image = image
    }
    
    private func setupCityView() {
        contentView.addSubview(cityView)
        cityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }

}
