//
//  FeaturedVideosCell.swift
//  CommunityMC3
//
//  Created by Theofani on 21/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

class FeaturedVideosCell: UITableViewCell {
    
    @IBOutlet weak var videoThumbnailImage: UIImageView!
    @IBOutlet weak var videoPlayButton: UIButton!
    
    var feature: FeaturedDataStruct!
    var player: Bool = false
    var audioPlayer: AVAudioPlayer!
    var mainTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoThumbnailImage.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func playUpload(_ sender: UIButton) {
        if feature != nil {
            player = true
            mainTableView.reloadData()
            DispatchQueue.main.async {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: (self.feature.track!.fileData?.fileURL!)!)
                    self.audioPlayer.delegate = self
                    self.audioPlayer.play()
                } catch {
                    print("play failed")
                }
            }
        }
    }
    
}

extension FeaturedVideosCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = false
        mainTableView.reloadData()
    }
}
