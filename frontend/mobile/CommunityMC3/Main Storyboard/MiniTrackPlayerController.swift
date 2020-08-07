//
//  MiniTrackPlayerController.swift
//  Allegro
//
//  Created by Rommy Julius Dwidharma on 06/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

protocol MiniTrackPlayerDelegate: class {
    func play(_ trackURL: String?)
    func stop()
}

class MiniTrackPlayerController: UIViewController, AVAudioPlayerDelegate, MiniTrackPlayerDelegate {

    @IBOutlet weak var trackProgressView: UIProgressView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var coverTrackImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    var trackPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func play(_ trackURL: String?) {
        var error: NSError? = nil
        let audioPath = Bundle.main.path(forResource: trackURL, ofType: "mp3")
        do{
            trackPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch let error1 as NSError{
            error = error1
        }
        trackPlayer!.delegate = self
        
        if error == nil {
            trackPlayer?.delegate = self
            trackPlayer?.prepareToPlay()
            trackPlayer?.play()
        }
    }
    
    func stop(){
        trackPlayer?.stop()
    }
    
}
