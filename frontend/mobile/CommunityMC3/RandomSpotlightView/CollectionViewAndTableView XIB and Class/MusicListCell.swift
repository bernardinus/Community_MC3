//
//  MusicListCell.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 24/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

class MusicListCell: UITableViewCell, AVAudioPlayerDelegate {
    
    
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    @IBOutlet weak var trackCurrent: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var play: Bool {
        return playButton.isSelected
    }
    var playlist = [String]()
    var trackPlayer: AVAudioPlayer?
    var indexForPlaylist = 0
    let randomizerVC = RandomSpotlightViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        playButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
//        playButton.setImage(#imageLiteral(resourceName: "Stop"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
//    @IBAction func directPlayButton(_ sender: UIButton) {
//        playButton.isSelected = !playButton.isSelected
//
//        let audioPath = Bundle.main.path(forResource: "\(playlist[indexForPlaylist])", ofType: "mp3")!
//        var error : NSError? = nil
//        do {
//            trackPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
//
//        } catch let error1 as NSError {
//            error = error1
//        }
//        trackPlayer!.delegate = self
//
//        if play == true {
//            if error == nil {
//                trackPlayer?.delegate = self
//                trackPlayer?.prepareToPlay()
//                trackPlayer?.play()
//
//            }
//        }else if play == false{
//            trackPlayer?.stop()
//        }
//    }
    
}
