//
//  TrackPlayerViewController.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation

class TrackPlayerViewController: UIViewController, AVAudioPlayerDelegate{
    
    @IBOutlet weak var trackCoverImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var trackProgressSlider: UISlider!
    @IBOutlet weak var trackCurrentTimeLabel: UILabel!
    @IBOutlet weak var trackDurationLabel: UILabel!
    @IBOutlet weak var repeatButtonNonActive: UIButton!
    @IBOutlet weak var repeatButtonActive: UIButton!
    @IBOutlet weak var repeatOneTrackOnlyButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var shuffleButtonActive: UIButton!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var track: TrackDataStruct!
    
    var trackPlayer: AVAudioPlayer?
    var displayLink : CADisplayLink! = nil
    var counter = 0
    var trackListTemp = [String]()
    var trackShuffleTemp = [String]()
    var trackPlaylist = [String]()
    var repeatPlaylistBoolean = true
    
    var favoriteBool: Bool {
        return favoriteButton.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
//        retreiveTrack()
//        prepareTrack()
//        prepareAndCustomizeSlider()
        favoriteButtonStateChange()
    }
    
    func retreiveTrack() {
        if track != nil {
            trackTitleLabel.text = track.name
            artistButton.setTitle(track.email, for: .normal)
        }
    }
    
    func prepareTrack() {
        var error : NSError? = nil
        if track != nil {
            let audioPath = track.fileURL
            do {
                trackPlayer = try AVAudioPlayer(contentsOf: audioPath)
                
            } catch let error1 as NSError {
                error = error1
            }
        }else {
            let audioPath = Bundle.main.path(forResource: "\(trackPlaylist[counter])", ofType: "mp3")!
//            let audioPath = Bundle.main.path(forResource: "", ofType: "mp3")!
            do {
                trackPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                
            } catch let error1 as NSError {
                error = error1
            }
        }
        let seconds = Int(trackPlayer!.duration)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(seconds))!
        trackDurationLabel.text = "\(formattedString)"
        print(seconds)
        
        print(trackProgressSlider.maximumValue)
        displayLink = CADisplayLink(target: self, selector: #selector(updateAudioProgressView))
        displayLink.preferredFramesPerSecond = 1
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
        trackProgressSlider.setThumbImage(#imageLiteral(resourceName: "trackThumbTint"), for: .normal)
        trackPlayer!.delegate = self
        if error == nil {
            trackPlayer!.delegate = self
            trackPlayer!.prepareToPlay()
            trackPlayer!.play()
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
            
                let minute = Int(trackPlayer!.duration / 60)
                let second = Int(trackPlayer!.duration) - minute * 60
            
            trackCurrentTimeLabel.text = "\(minute):\(String(format: "%2d", second))"
           }
       }
    
    func favoriteButtonStateChange(){
        favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
        favoriteButton.setImage(#imageLiteral(resourceName: "HeartFill"), for: .selected)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){

            if flag {
                counter+=1
            }

            if (counter == trackPlaylist.count) {
                counter = 0
            }
            prepareTrack()
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
            if counter == 0{
                trackPlayer!.currentTime = 0
                trackPlayer!.play()
            }else{
                counter -= 1
                prepareTrack()
            }
        }else if sender == nextButton{
            if counter == trackPlaylist.count-1 {
                if repeatPlaylistBoolean == true{
                    counter = 0
                    prepareTrack()
                }else {
                    counter = 0
                    prepareTrack()
                    trackPlayer!.currentTime = 0
                    trackPlayer!.stop()
                    pauseButton.isHidden = true
                    playButton.isHidden = false
                }
            }else{
                counter += 1
                prepareTrack()
            }
        }
    }
    
    @IBAction func trackProgressSliderAction(_ sender: UISlider) {
        trackPlayer!.stop()
        trackPlayer!.currentTime = TimeInterval(trackProgressSlider.value)
        trackPlayer!.prepareToPlay()
        trackPlayer!.play()
        trackCurrentTimeLabel.text = "\( TimeInterval(trackProgressSlider.value))"
    }
    
    @IBAction func repeatButtonAction(_ sender: UIButton) {
        if sender == repeatButtonNonActive {
            repeatOneTrackOnlyButton.isHidden = true
            repeatButtonActive.isHidden = false
            repeatButtonNonActive.isHidden = true
            
            repeatPlaylistBoolean = true
        }else if sender == repeatButtonActive{
            repeatButtonNonActive.isHidden = true
            repeatButtonActive.isHidden = true
            repeatOneTrackOnlyButton.isHidden = false
            
            repeatPlaylistBoolean = false
            trackPlayer!.numberOfLoops = -1
        }else if sender == repeatOneTrackOnlyButton{
            repeatOneTrackOnlyButton.isHidden = true
            repeatButtonNonActive.isHidden = true
            repeatButtonNonActive.isHidden = false
            
            repeatPlaylistBoolean = false
            trackPlayer!.numberOfLoops = 0
        }
    }
    
    @IBAction func shuffleButtonAction(_ sender: UIButton) {
        if sender == shuffleButton{
            shuffleButton.isHidden = true
            shuffleButtonActive.isHidden = false
            
            trackShuffleTemp.removeAll()
            trackShuffleTemp.append(contentsOf: trackListTemp)
            trackShuffleTemp.shuffle()
            trackPlaylist.removeAll()
            trackPlaylist.append(contentsOf: (trackShuffleTemp))
        }else if sender == shuffleButtonActive{
            shuffleButtonActive.isHidden = true
            shuffleButton.isHidden = false
            
            trackPlaylist.removeAll()
            trackPlaylist.append(contentsOf: trackListTemp)
        }
    }
    
    @IBAction func artistButton(_ sender: UIButton) {
        
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        print(favoriteBool)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        trackPlayer?.stop()
        super .viewWillDisappear(animated)
    }
}
