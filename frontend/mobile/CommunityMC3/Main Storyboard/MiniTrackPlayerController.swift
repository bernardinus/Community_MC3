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
    func play(trackURL: URL)
    func stop()
    func pause()
    func miniTrackPlayerButtonState(state: Bool?)
}

class MiniTrackPlayerController: UIViewController, AVAudioPlayerDelegate, MiniTrackPlayerDelegate {
    

    @IBOutlet weak var trackProgressView: UIProgressView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var coverTrackImage: UIImageView!
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    
    var trackPlayer: AVAudioPlayer?
    var updater : CADisplayLink! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
    }
    
    func setup(){
        playAndPauseButton.setImage(#imageLiteral(resourceName: "PlayButtonFullColor"), for: .normal)
        playAndPauseButton.setImage(#imageLiteral(resourceName: "pauseFullColor"), for: .selected)
        
        playAndPauseButton.isSelected = false
        trackProgressView.progress = 0.0

        updater = CADisplayLink(target: self, selector: #selector(updateTrackProgress))
        updater.preferredFramesPerSecond = 1
        updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
        TrackManager.shared.delegate = self
    }
    
    func play(trackURL: URL) {
                var error: NSError? = nil
//        let audioPath = Bundle.main.path(forResource: trackURL, ofType: "mp3")
        do{
            trackPlayer = try AVAudioPlayer(contentsOf: trackURL)
        } catch let error1 as NSError{
            error = error1
        }
        trackPlayer!.delegate = self
        
        if error == nil {
            trackPlayer?.delegate = self
            trackPlayer?.prepareToPlay()
            trackPlayer?.play()
            
            playAndPauseButton.isSelected = true
        }
        
    }
    
    func stop(){
        trackPlayer?.stop()
        trackPlayer?.currentTime = 0
        trackProgressView.progress = 0.0
    }
    
    func pause() {
        trackPlayer?.pause()
    }
    
    func miniTrackPlayerButtonState(state: Bool?) {
        playAndPauseButton.isSelected = state!
    }
    
    @objc func updateTrackProgress(){
        if trackPlayer?.isPlaying == true{
            let trackProgress = Float(self.trackPlayer!.currentTime / self.trackPlayer!.duration)
            self.trackProgressView.progress = trackProgress
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationSegue = segue.destination as! TrackPlayerViewController
        destinationSegue.trackPlayer = trackPlayer
        destinationSegue.miniTrackDelegate = self
        
        if playAndPauseButton.isSelected == true {
            destinationSegue.playAndPauseBoolean = true
        }else{
            destinationSegue.playAndPauseBoolean = false
        }
    }
    
    
    @IBAction func playAndPauseButtonTouched(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true{
            trackPlayer?.play()
            playAndPauseButton.isSelected = true
        }else if sender.isSelected == false{
            trackPlayer?.pause()
            playAndPauseButton.isSelected = false
        }
    }
    
   
    
}
