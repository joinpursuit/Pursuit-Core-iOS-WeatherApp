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

    let defaultMessage = "Weather Forecast For City"
    
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemTeal
        label.text = defaultMessage
        return label
    }()
    
    public lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.backgroundColor = .systemBackground
        //searchbar.layer.borderColor = UIColor.black.cgColor // does not work - search how to set it
        searchbar.placeholder = "Enter a Zip Code"
        return searchbar
    }()
    
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
        setupSearchBarConstraints()
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
    
    private func setupSearchBarConstraints(){
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    

}
