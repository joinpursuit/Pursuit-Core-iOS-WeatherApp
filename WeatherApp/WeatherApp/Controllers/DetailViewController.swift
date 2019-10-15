//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Angela Garrovillas on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Properties
    var dailyWeather: DataWrapper?
    var name: String?
    var detailStackView = WeatherStackView()
    
    private func setupDetailUI() {
        setupStackView()
    }
    private func setupStackView() {
        view.addSubview(detailStackView)
        NSLayoutConstraint.activate([
            detailStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            detailStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDetailUI()
    }
    

}
