//
//  TrendingNowCell.swift
//  CommunityMC3
//
//  Created by Bernardinus on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

class TrendingNowCell: UITableViewCell {
    
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var favoriteIconButton: UIButton!
    @IBOutlet weak var trackTimerLabel: UILabel!
    @IBOutlet weak var playMusicButton: UIButton!
    
    var trackData:TrackDataStruct?
//    var trending: FeaturedDataStruct!
//    var trendings: [PrimitiveTrackDataStruct]!
//    var videos: [PrimitiveVideosDataStruct]!
    var player: Bool = false
    var audioPlayer: AVAudioPlayer!
    var mainTableView: UITableView!
//    let documentController = DocumentTableViewController.shared
//    let uploadController = UploadController.shared
//    var email: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteButtonStateChange()
        retreiveFavorites()
    }
    
    func updateData(trackData:TrackDataStruct)
    {
        self.trackData = trackData
        trackTitleLabel.text = trackData.name
        artistNameLabel.text = trackData.artistName
        if player {
            playMusicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else{
            playMusicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func favoriteButtonStateChange(){
        
        favoriteIconButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
        favoriteIconButton.setImage(#imageLiteral(resourceName: "HeartFill"), for: .selected)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func playTrending(_ sender: UIButton) {
        if trackData != nil {
            player = true
            mainTableView.reloadData()
            DispatchQueue.main.async {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: (self.trackData!.fileData?.fileURL!)!)
                    self.audioPlayer.delegate = self
                    self.audioPlayer.play()
                } catch {
                    print("play failed")
                }
            }
        }
    }
    
    @IBAction func favoriteUpload(_ sender: UIButton) {
        favoriteIconButton.isSelected = !favoriteIconButton.isSelected
        changeFavourites()
        //        print(favoriteBool)
    }
    
    func changeFavourites() {
        /*
        if trending.track != nil {
            let temp = PrimitiveTrackDataStruct(
                genre: trending.track!.genre,
                name: trending.track!.name,
                email: trending.track!.email
            )
            var counter = 0
            var flag = false
            for trending in trendings {
                if trending.name == self.trending.track!.name {
                    flag = true
                    trendings.remove(at: counter)
                }
                counter += 1
            }
            if !flag {
                trendings.append(temp)
            }
            
            documentController.uploadFavorite(id: email, track: trendings)
        }
        if trending.video != nil {
            let temp = PrimitiveVideosDataStruct(
                genre: trending.video!.genre,
                name: trending.video!.name,
                email: trending.video!.email
            )
            var counter = 0
            var flag = false
            for video in videos {
                if video.name == self.trending.video!.name {
                    flag = true
                    videos.remove(at: counter)
                }
                counter += 1
            }
            if !flag {
                videos.append(temp)
            }
            
            uploadController.uploadFavorite(id: email, video: videos)
        }
        */
    }
    
    func retreiveFavorites() {
        /*
        documentController.getFavoritesFromCloudKit { (favourites) in
            for favourite in favourites {
                if self.email != "" && favourite.id == self.email {
                    self.trendings = favourite.track!
                    self.videos = favourite.videos!
                }
            }
            //            print("current", self.trendings.count)
            if self.trending.track != nil {
                for trending in self.trendings {
                    if trending.name == self.trending.track!.name {
                        DispatchQueue.main.async {
                            self.favoriteIconButton.isSelected = !self.favoriteIconButton.isSelected
                        }
                    }
                }
            }
            if self.trending.video != nil {
                /*
                for video in self.videos {
                    if video.name == self.trending.video!.name {
                        DispatchQueue.main.async {
                            self.favoriteIconButton.isSelected = !self.favoriteIconButton.isSelected
                        }
                    }
                }
 */
            }
        }
        */
    }
    
    
}

extension TrendingNowCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = false
        mainTableView.reloadData()
    }
}
