//
//  ThirdViewController.swift
//  CommunityMC3
//
//  Created by Bryanza on 06/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum Favorite: Int{
    case FavoriteTrack = 0
    case FavoriteVideo = 1
    case Albums = 2
    case Artist = 3
    
    case Count = 4
}

class FavouritesView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "FavoritesMenuCell", bundle: nil), forCellReuseIdentifier: "favoriteMenuCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.shadowImage = nil
        super.viewWillAppear(true)
    }
    @IBAction func unwindToFavorite(_ segue: UIStoryboardSegue){
        
    }


}
extension FavouritesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Favorite.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Favorite.FavoriteTrack.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMenuCell", for: indexPath) as! FavoritesMenuCell
            cell.cellTitleLabel.text = "Favorite Tracks"
            return cell
        }else if indexPath.section == Favorite.FavoriteVideo.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMenuCell", for: indexPath) as! FavoritesMenuCell
            cell.cellTitleLabel.text = "Favorite Videos"
            return cell
        }else if indexPath.section == Favorite.Albums.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMenuCell", for: indexPath) as! FavoritesMenuCell
            cell.cellTitleLabel.text = "Albums"
            return cell
        }else if indexPath.section == Favorite.Artist.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMenuCell", for: indexPath) as! FavoritesMenuCell
            cell.cellTitleLabel.text = "Artists"
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "favoriteMenuCell")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "favoriteTracks", sender: self)
            
        }else if indexPath.row == 1{
            performSegue(withIdentifier: "favoriteVideos", sender: self)
        }
    }
}
