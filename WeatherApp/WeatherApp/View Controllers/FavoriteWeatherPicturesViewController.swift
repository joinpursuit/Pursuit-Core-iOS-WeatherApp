//
//  FavoriteWeatherPicturesViewController.swift
//  WeatherApp
//
//  Created by Donkemezuo Raymond Tariladou on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteWeatherPicturesViewController: UIViewController {
    @IBOutlet weak var savedPhotosTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedPhotosTableView.delegate = self
        savedPhotosTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    


}

extension FavoriteWeatherPicturesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = savedPhotosTableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? SavedPicturesTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    
}
