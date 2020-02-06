//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ahad Islam on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var highLowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupDateLabel()
        setupHighLowLabel()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(forecast: DailyDatum) {
        dateLabel.text = "OK"
        highLowLabel.text = "High: \(forecast.temperatureHigh)℃ \nLow: \(forecast.temperatureLow)℃"
        imageView.image = UIImage(named: forecast.icon)
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    
    private func setupHighLowLabel() {
        contentView.addSubview(highLowLabel)
        
        highLowLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            highLowLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            highLowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            highLowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: highLowLabel.topAnchor)])
    }
}
