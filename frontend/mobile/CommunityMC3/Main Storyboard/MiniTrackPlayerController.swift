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
    func play(data: TrackDataStruct)
    func stop()
    func pause()
    func miniTrackPlayerButtonState(state: Bool?)
}

class MiniTrackPlayerController: UIViewController {
    
    
    @IBOutlet weak var trackProgressView: UIProgressView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var coverTrackImage: UIImageView!
    @IBOutlet weak var playAndPauseButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    var trackPlayer: AVAudioPlayer?
    var updater : CADisplayLink! = nil
    var trackData:TrackDataStruct? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isHidden = true
        setup()
    }
    
    func updateLayout()
    {
        trackTitleLabel.text = trackData?.name
        artistLabel.text = trackData?.artistName
        coverTrackImage.image = trackData?.coverImage
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y + 100, width: contentView.frame.width, height: contentView.frame.height)
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

// MARK: EXTENSION
extension MiniTrackPlayerController:MiniTrackPlayerDelegate
{
    func play(data: TrackDataStruct)
    {
        trackData = data
        updateLayout()
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
            self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y - 100, width: self.contentView.frame.width, height: self.contentView.frame.height)
        }, completion: nil )
        self.view.isHidden = false
        var error: NSError? = nil
        //        let audioPath = Bundle.main.path(forResource: trackURL, ofType: "mp3")
        do{
            trackPlayer = try AVAudioPlayer(contentsOf: data.fileData!.fileURL!)
        }
        catch let error1 as NSError
        {
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
}

extension MiniTrackPlayerController:AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playAndPauseButton.isSelected = false
    }

}
