//
//  ThirdViewController.swift
//  CommunityMC3
//
//  Created by Bryanza on 06/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import CloudKit

enum Favorite: Int{
    case FavoriteTrack = 0
    case FavoriteVideo = 1
    case Albums = 2
    case Artist = 3
    
    case Count = 4
}

class FavouritesView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let documentController = DocumentTableViewController.shared
    var countTracks = [TrackDataStruct]()
    var countVideos = [VideosDataStruct]()
    var uploads: [CKRecord]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "FavoritesMenuCell", bundle: nil), forCellReuseIdentifier: "favoriteMenuCell")
        retrieveFavorite()
        retrieveUpload()
    }
    
    func retrieveUpload() {
        if uploads != nil {
            for upload in uploads {
                let track = upload.value(forKey: "track") as! CKRecord
                var counter = 0
                for countTrack in countTracks {
                    if track.value(forKey: "name") as! String == countTrack.name {
                        let asset = (track.value(forKey: "fileURL") as? CKAsset)!
                        countTracks[counter].fileURL = asset.fileURL!
                    }
                    counter += 1
                }
                counter = 0
                let video = upload.value(forKey: "video") as! CKRecord
                for countVideo in countVideos {
                    if video.value(forKey: "name") as! String == countVideo.name {
                        let asset = (video.value(forKey: "fileURL") as? CKAsset)!
                        countVideos[counter].fileURL = asset.fileURL!
                    }
                    counter += 1
                }
            }
        }
    }
    
    func retrieveFavorite() {
        documentController.getFavoritesFromCloudKit { (favourites) in
            var tracks = [PrimitiveTrackDataStruct]()
            var videos = [PrimitiveVideosDataStruct]()
            for favourite in favourites {
                if favourite.id == UserDefaults.standard.string(forKey: "email") {
                    if favourite.track != nil {
                        tracks = favourite.track!
                    }
                    if favourite.videos != nil {
                        videos = favourite.videos!
                    }
                }
            }
            for track in tracks {
                self.countTracks.append(
                    TrackDataStruct(
                        genre: track.genre,
                        name: track.name,
                        email: track.email,
                        fileURL: URL(fileURLWithPath: "")
                    )
                )
            }
            for video in videos {
                self.countVideos.append(
                    VideosDataStruct(
                        genre: video.genre,
                        name: video.name,
                        email: video.email,
                        fileURL: URL(fileURLWithPath: "")
                    )
                )
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.shadowImage = nil
        super.viewWillAppear(true)
    }
    
    @IBAction func unwindToFavorite(_ segue: UIStoryboardSegue){
        
    }
    
    // MARK: Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteTracks" {
            if let trackPlayerPage = segue.destination as? FavoriteTracksView {
                trackPlayerPage.countTracks = countTracks
            }
        }
        if segue.identifier == "favoriteVideos" {
            if let videoPlayerPage = segue.destination as? FavoriteVideosView {
                videoPlayerPage.countVideos = countVideos
            }
        }
    }
    
    
}
extension FavouritesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countTracks.count + countVideos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Favorite.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMenuCell", for: indexPath) as! FavoritesMenuCell
        if indexPath.section == Favorite.FavoriteTrack.rawValue
        {
            cell.cellTitleLabel.text = "Favorite Tracks"
            cell.countLabel.text = String(countTracks.count)
        }
        else if indexPath.section == Favorite.FavoriteVideo.rawValue
        {
            cell.cellTitleLabel.text = "Favorite Videos"
            cell.countLabel.text = String(countVideos.count)
        }
        else if indexPath.section == Favorite.Albums.rawValue
        {
            cell.cellTitleLabel.text = "Albums"
            cell.countLabel.text = String(0)
        }
        else if indexPath.section == Favorite.Artist.rawValue
        {
            cell.cellTitleLabel.text = "Artists"
            cell.countLabel.text = String(0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == Favorite.FavoriteTrack.rawValue
        {
            performSegue(withIdentifier: "favoriteTracks", sender: self)
            
        }
        else if indexPath.section == Favorite.FavoriteVideo.rawValue {
            performSegue(withIdentifier: "favoriteVideos", sender: self)
        }
    }
}
