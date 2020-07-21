//
//  TrackPlayerViewController.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

class TrackPlayerViewController: UIViewController {
    
    @IBOutlet weak var trackCoverImageView: UIImageView!
    @IBOutlet weak var artisLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var trackProgressSlider: UISlider!
    
    var trackPlayer: AVAudioPlayer?
    var displayLink : CADisplayLink! = nil
    var repeatTrack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTrack()
        prepareAndCustomizeSlider()
    }
    
    func prepareTrack() {
        guard let soundURL = Bundle.main.path(forResource: " ", ofType: "mp3") else {return}
        do{
            trackPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundURL, isDirectory: true))
            trackPlayer!.play()
            print("audio played")
        }catch{
            print(error)
        }
    }
    
    func prepareAndCustomizeSlider() {
        //Slider customization
        trackProgressSlider.setThumbImage(#imageLiteral(resourceName: "trackThumbTint"), for: .normal)
        
        //Slider display track progress
        displayLink = CADisplayLink(target: self, selector: #selector(updateAudioProgressView))
        displayLink.preferredFramesPerSecond = 1
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
    }
    
    @objc func updateAudioProgressView()
       {
        if trackPlayer!.isPlaying
           {
               trackProgressSlider.minimumValue = 0.0
               trackProgressSlider.maximumValue = Float(trackPlayer!.duration)
               trackProgressSlider.setValue(Float(trackPlayer!.currentTime), animated: true)
           }
       }
    
    @IBAction func pauseAndPlayButtonAction(_ sender: UIButton) {
        if sender == pauseButton{
            trackPlayer!.pause()
            pauseButton.isHidden = true
            playButton.isHidden = false
        }else if sender == playButton{
            trackPlayer!.play()
            playButton.isHidden = true
            pauseButton.isHidden = false
        }
    }
    
    @IBAction func prevAndNextButtonAction(_ sender: UIButton) {
        if sender == prevButton{
            
        }else if sender == nextButton{
            
        }
    }
    
    @IBAction func trackProgressSliderAction(_ sender: UISlider) {
        trackPlayer!.stop()
        trackPlayer!.currentTime = TimeInterval(trackProgressSlider.value)
        trackPlayer!.prepareToPlay()
        trackPlayer!.play()

    }
    
    @IBAction func repeatButtonAction(_ sender: UIButton) {
        repeatTrack = true
        if repeatTrack == true{
            trackPlayer!.numberOfLoops = -1
        }
    }
    
    
}
