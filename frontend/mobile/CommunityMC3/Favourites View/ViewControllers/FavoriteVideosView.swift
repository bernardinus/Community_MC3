//
//  FavoriteVideosView.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVKit

class FavoriteVideosView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var countVideos: [VideosDataStruct]!
    var countFavorites = [PrimitiveVideosDataStruct]()
    let uploadController = UploadController.shared
    
    var videoPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FavoriteVideosCell", bundle: nil), forCellReuseIdentifier: "favoriteVideosCell")
        //        convertFavourites()
        countVideos = DataManager.shared().favVideoData
    }
    
    func convertFavourites() {
        for video in countVideos {
            countFavorites.append(
                PrimitiveVideosDataStruct(
                    genre: video.genre,
                    name: video.name,
                    email: video.email
                )
            )
        }
    }
    
    func changeFavourites(video: VideosDataStruct) {
        let temp = PrimitiveVideosDataStruct(
            genre: video.genre,
            name: video.name,
            email: video.email
        )
        var counter = 0
        var flag = false
        for video in countFavorites {
            if video.name == temp.name {
                flag = true
                countFavorites.remove(at: counter)
            }
            counter += 1
        }
        if !flag {
            countFavorites.append(temp)
        }
        let email = UserDefaults.standard.string(forKey: "email")
        
        uploadController.uploadFavorite(id: email!, video: countFavorites)
    }
    
    @objc func clickPlayVideo(_ sender: UIButton){
        /*
         let video: AVPlayer
         if countVideos != nil {
         let videoURL = countVideos[sender.tag].fileData!.fileURL!
         let videoData = NSData(contentsOf: videoURL as URL)
         
         let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
         let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent(countVideos[sender.tag].name + ".mov", isDirectory: false) //This is where I messed up.
         
         FileManager.default.createFile(atPath: (destinationPath?.path)!, contents:videoData as Data?, attributes:nil)
         
         video = AVPlayer(url: destinationPath!)
         
         }else {
         if let urlString = Bundle.main.path(forResource: "", ofType: "mp4"){
         video = AVPlayer(url: URL(fileURLWithPath: urlString))
         }else{
         video = AVPlayer()
         }
         }
         let videoPlayer = AVPlayerViewController()
         videoPlayer.player = video
         
         //enter video player mode
         self.present(videoPlayer, animated: true, completion: {
         video.play()
         })
         */
    }
    
    @objc func favoriteButtonState(_ sender: UIButton){
        /*
         sender.isSelected = !sender.isSelected
         let selectedIndex = IndexPath(row: sender.tag, section: 0)
         
         changeFavourites(video: countVideos[sender.tag])
         
         if sender.isSelected == false{
         let cell = tableView.cellForRow(at: selectedIndex) as! FavoriteVideosCell
         
         cell.favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
         
         self.tableView.reloadData()
         }
         */
    }
    
    
}


extension FavoriteVideosView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countVideos != nil {
            return countVideos.count
        }
        return 5//0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteVideosCell", for: indexPath) as! FavoriteVideosCell
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonState(_:)), for: .touchUpInside)
        
//            let videoUrl = Bundle.main.path(forResource: " ", ofType: "mp4")
//            let urls = URL(fileURLWithPath: videoUrl!)
                
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(clickPlayVideo(_:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TrackManager.shared.playVideo(view: self, videoData: countVideos[indexPath.row])
    }
}
