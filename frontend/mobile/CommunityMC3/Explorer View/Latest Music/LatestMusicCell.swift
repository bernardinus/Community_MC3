//
//  LatestMusicCell.swift
//  CommunityMC3
//
//  Created by Theofani on 21/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

class LatestMusicCell: UITableViewCell {
    
    @IBOutlet weak var playMusicButton: UIButton!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var musicImageView: UIButton!
//    @IBOutlet weak var genreLabel: UILabel!
//    @IBOutlet weak var indicatorImage: UIImageView!
    
    let musicImg:UIImage = UIImage(systemName: "music.note")!
    let videoImg:UIImage = UIImage(systemName: "play.rectangle.fill")!
    
    var upload: UploadedDataStruct!
    var player: Bool = false
    var audioPlayer: AVAudioPlayer!
    var mainTableView: UITableView!
    var dt:UploadedDataStruct?
    //    let documentController = DocumentTableViewController.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCellData(data:UploadedDataStruct)
    {
        upload = dt
        self.dt = data
        if(dt!.isVideo)
        {
            print("uploadedVideo \(dt?.videoRecord)")
            trackTitleLabel.text = dt?.videoData?.name
//            artistNameLabel.text = dt?.videoData.artistName
//            musicImageView.imageView?.image = videoController.generateThumbnail(path: uploads[indexPath.row].video!.fileURL)

        }
        else
        {
//            print("uploadedTrack \(dt?.trackRecord)")
            trackTitleLabel.text = dt?.trackData?.name
//            artistNameLabel.text = dt?.trackData?.artistName
//            print("masuk ", player)
            if player
            {
                playMusicButton.imageView?.image = UIImage(systemName: "pause.fill")
                playMusicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
            else
            {
                playMusicButton.imageView?.image = UIImage(systemName: "play.fill")
                playMusicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
                  
        }
        
    }
    
    @IBAction func directPlay(_ sender: UIButton) {
        if upload.trackRecord != nil {
            
//            setupUIViewForGenre(view: genreLabel, genre: "RnB")
//            indicatorImage.image = musicImg
            
            player = true
            mainTableView.reloadData()
            //        playMusicButton.imageView?.image = UIImage(systemName: "pause.fill")
            //        let playerGroup = DispatchGroup()
            //        playerGroup.enter()
            DispatchQueue.main.async {
                do {
//                    self.audioPlayer = try AVAudioPlayer(contentsOf: self.upload.track!.fileURL)
                    self.audioPlayer.delegate = self
                    self.audioPlayer.play()
                    //                playerGroup.leave()
                }
                catch
                {
                    print("play failed")
                }
            }
            //        playerGroup.notify(queue: .main) {
            //        }
            //        if player {
            //            player = false
            //        }else{
            //            player = true
            //        }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension LatestMusicCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //        playMusicButton.imageView?.image = UIImage(systemName: "play.fill")
        self.player = false
        mainTableView.reloadData()
    }
}
