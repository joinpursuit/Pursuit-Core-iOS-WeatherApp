//
//  SearchWeatherController.swift
//  WeatherApp
//
//  Created by Yuliia Engman on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class SearchWeatherController: UIViewController {
    
    private let searchWeatherView = SearchWeatherView()
    
//    private var weather = [Weather]() { // is it correct?
//      didSet {
//        // 13.
//          DispatchQueue.main.async {
//              self.searchWeatherView.collectionView.reloadData()
//          }
//      }
//    }
    
    override func loadView() {
        view = searchWeatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Weather Search"
        
        searchWeatherView.collectionView.dataSource = self
        searchWeatherView.collectionView.delegate = self
        searchWeatherView.collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "weatherCell")
        
        //fetchPodcasts()
        }
        
//        private func fetchPodcasts(_ name: String = "swift") {
//          PodcastAPIClient.fetchPodcast(with: name) { (result) in
//            switch result {
//            case .failure(let appError):
//              print("error fetching podcasts: \(appError)")
//            case .success(let podcasts):
//              self.podcasts = podcasts
//            }
//          }
//        }

}

extension SearchWeatherController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // will need to change!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCellCollectionViewCell else {
            fatalError("could not downcast to WeatherCellCollectionViewCell")
        }
        cell.backgroundColor = .white
        return cell
    }
}

extension SearchWeatherController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.5
        return CGSize(width: itemWidth, height: 350)
    }
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//let podcast = podcasts[indexPath.row]
    let detailVC = DetailViewController ()
    
    navigationController?.pushViewController(detailVC, animated: true)
//        //print(podcast.collectionName)
//        print("row selected \(indexPath.row)")
//        // segue to the PodcastDetailController
//        // access the PodcastDetailController from Storyboard
//        
//        // make sure that the storyboard id is set for the PodcastDetailController
//let podcastDetailStoryboard = UIStoryboard(name: "PodcastDetail", bundle: nil)
//        guard let podcastDetailController = podcastDetailStoryboard.instantiateViewController(identifier: "PodcastDetailController") as? PodcastDetailController else {
//            fatalError("coulod not downcast to PodcastDetailController")
//        }
//        podcastDetailController.podcast = podcast
//        
//        // nest week we will pass data using initializer/dependancy injection e.g. PodcastDetailController(podcast: podcast)
//        
//        navigationController?.pushViewController(podcastDetailController, animated: true)
//        
//        //show(podcastDetailController, sender: nil)
//    }
}
}
