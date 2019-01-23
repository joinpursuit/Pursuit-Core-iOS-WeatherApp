//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Biron Su on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteImages = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImages()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        updateImages()
    }
    func updateImages() {
        favoriteImages = FavoriteImageModel.getImages()
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "tableCell") as? FavoriteTableViewCell else {return UITableViewCell()}
        cell.favoriteCell.image = UIImage(data: favoriteImages[indexPath.row])
//        ImageHelper.shared.fetchImage(urlString: favoriteImages[indexPath.row]) { (error, image) in
//            if let error = error {
//                print("error in favorite tableview \(error)")
//            } else if let image = image {
//                cell.favoriteCell.image = image
//            }
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
