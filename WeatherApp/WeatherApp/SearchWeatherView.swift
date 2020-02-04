//
//  SearchWeatherView.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class SearchWeatherView: UIView {

    private var weather = [Weather]()
    
    let defaultMessage = "Weather Forecast For City"
    
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemTeal
        label.text = defaultMessage
        return label
    }()
    
    public lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .systemBackground
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.textAlignment = .center
        textfield.placeholder = "Enter a Zip Code"
        updateView()
        return textfield
    }()
    
    private func updateView() {
               // retrieve any values in UserDefaults as needed
               if let userZipcode = UserPreference.shared.getUserZipcode() {
                textField.text = userZipcode
               }
           }
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 250)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupMessageLabelConstraints()
        setupTextFieldConstraints()
        setupCollectionViewConstraints()
    }
    
    private func setupMessageLabelConstraints() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant:  50),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTextFieldConstraints(){
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    

}
