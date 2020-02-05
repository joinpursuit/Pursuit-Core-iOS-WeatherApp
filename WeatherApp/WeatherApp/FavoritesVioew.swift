//
//  FavoritesVioew.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesVioew: UIView {
    
    private lazy var tableView: UITableView = {
      let tv = UITableView()
    return tv
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
         setUpTableViewConstraints()
       }

    private func setUpTableViewConstraints() {
           addSubview(tableView)
           tableView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
               tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
               tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
           ])
       }
}
