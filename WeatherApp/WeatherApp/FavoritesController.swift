//
//  FavoritesController.swift
//  WeatherApp
//
//  Created by Liubov Kaper  on 2/3/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesController: UIViewController {

    var dataPersistance: DataPersistence<ImageObject>!
    
    @IBOutlet weak var tableView: UITableView!
    
    var faveImages = [ImageObject]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadImages()
    }
    

    private func loadImages() {
        do {
            faveImages = try dataPersistance.loadItems()
        } catch {
            print("error loading images: \(error)")
        }
    }

}

extension FavoritesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faveImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "faveCell", for: indexPath) as? FAvoritesCell else {
            fatalError("could not downcast to FavoriteCell")
        }
        let favImage = faveImages[indexPath.row]
        cell.confugureCell(for: favImage)
        return cell
        
    }
   
}

extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
