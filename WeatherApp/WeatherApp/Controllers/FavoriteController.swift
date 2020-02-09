//
//  FavoriteImageController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
      // data for the table view
    //    var animals = [ZooAnimal](){
    //        didSet {
    //            tableView.reloadData()
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        tableView.dataSource = self
        tableView.delegate = self
       // loadData()
        
        // FIXME: write extension for this tableView:
        //tableView.dataSource = self
        //tableView.delegate = self
        
       // FIXME: I register here tableView cell, but I think I need to create tableView on FavoriteView.swift (look how did we do with collection view)
        // tableView.register(UINib(nibName: "FavoriteImageCell", bundle: nil), forCellReuseIdentifier: "favoriteImageCell")))
    }
    
     //  func loadData() {
    //        animals = ZooAnimal.zooAnimals
    //    }
}

extension FavoriteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: return saved pictures
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePictureCell", for: indexPath) as? FavoritePictureCell else {
                    fatalError("failed to deque an FavoritePictureCell")
        
                }
        //        // get the current object (animal) at the indexPath
        //        let animal = animals[indexPath.row]
        
        //        // configure the cell
        //        cell.configureCell(for: animal)
    
                return cell
            }
}

extension FavoriteController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
}

//import UIKit
//
//class CustomCellViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//    // data for the table view
//    var animals = [ZooAnimal](){
//        didSet {
//            tableView.reloadData()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        loadData()
//    }
//
//

//
//
//}
//
//
//extension CustomCellViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return animals.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as? AnimalCell else {
//            fatalError("failed to deque an animalCell") // crashes if AnimalCell is not setup correctly
//
//        }
//
//        // get the current object (animal) at the indexPath
//        let animal = animals[indexPath.row]
//
//        // configure the cell
//        cell.configureCell(for: animal)
//
//        return cell
//    }
//}
//
//extension CustomCellViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//
//    }
//}

