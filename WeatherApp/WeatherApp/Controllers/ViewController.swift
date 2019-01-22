//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var forecastCity: UILabel!
    @IBOutlet weak var weatherCV: UICollectionView!
    @IBOutlet weak var searchButton: UITextField!
    
    public var forecastImages = [Periods](){
        didSet {
            weatherCV.reloadData()
        }
    }
    private var imagePickerVC: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCV.dataSource = self
        print(DataPersistenceManager.documentsDirectory())
    }
    override func viewWillAppear(_ animated: Bool) {
        weatherCV.reloadData()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        present(vc, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCV.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell()}
        //let item = Periods
        
        return cell
    }
}
