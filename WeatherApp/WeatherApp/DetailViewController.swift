//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class DetailViewController: UIViewController {
    private var images = [Hit]()

    private let detailView = WeatherDetailView()
    public var weather: DailyDatum?
    
    public var location: String?
    
    
    var dataPersistance = DataPersistence<ImageObject>(filename: "photo.plist")
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
        configureNavBar()
    }
   
    
    func updateUI() {
        guard let weatherInfo = weather else {
            fatalError(" could not get weather")
        }
        detailView.weatherLabel.text = weatherInfo.temperatureHigh.description
        detailView.weatherLabel.backgroundColor = .yellow
        ImageAPIClient.getAllImageInfo(for: location!.replacingOccurrences(of: " ", with: ""), completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not fetch images with error \(appError)")
            case .success(let images):
                DispatchQueue.main.async {
                    self!.detailView.weatherImage.getImage(with: (images.hits.randomElement()?.largeImageURL!)!) { (result) in
                        switch result {
                        case .failure(let appError):
                            print("error: \(appError)")
                        case .success(let image):
                            DispatchQueue.main.async {
                                self!.detailView.weatherImage.image = image
                            }
                        }
                    }

                }
                
            }
        })

    }
    
    private func configureNavBar() {
        // set title of Navigation bar
        navigationItem.title = "Weather"
        
        // adding UIBarButtonItem to Navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addToFave(_:)))
    }
    @objc
    private func addToFave(_ sender: UIBarButtonItem) {
       // segue to the settingsVC
//        let settingsVC = SettingsViewController()
//        navigationController?.pushViewController(settingsVC, animated: true)
        
        // or this: Will present modally(different styles)
       // present(settingsVC, animated: true)
       // settingsVC.modalPresentationStyle = .overCurrentContext
        //settingsVC.modalTransitionStyle = .flipHorizontal
        
        guard let image = detailView.weatherImage.image else {
            return
        }
        if let imageData = image.jpegData(compressionQuality: 0.5){
            let imageObjectData = ImageObject(image: imageData)
            do {
                       try dataPersistance.createItem(imageObjectData)
                   } catch {
                       print("error saviong \(error)")
                   }
        }
        
       

        sender.isEnabled = false
    }
    
}
