//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Stephanie Ramirez on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var savedImages = [SavedImage]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
//        collectionView.delegate = self
        savedImages = PixabayModel.getImage()
        print(DataPersistenceManager.documentsDirectory())
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedImages = PixabayModel.getImage()
        collectionView.reloadData()
    }

}
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PixabayModel.getImage().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePhotoCell", for: indexPath) as? FavoritePhotoCell else { return UICollectionViewCell()}
        let photo = PixabayModel.getImage()[indexPath.row]
        cell.imageView.image = UIImage(data: photo.imageData)
//        let photo = PhotoJournalModel.getPhotoJournal()[indexPath.row]
//        cell.layer.cornerRadius = 20.0
//        cell.descriptionLabel.text = photo.description
//        cell.timestampLabel.text = photo.createdAt
//        cell.imageView.image = UIImage(data: photo.imageData)
//        cell.optionsButton.tag = indexPath.row
//        cell.delegate = self
        return cell
    }
}
