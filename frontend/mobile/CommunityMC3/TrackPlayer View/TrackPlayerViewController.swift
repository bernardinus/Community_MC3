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
    
    @IBOutlet weak var trackPlayerTitleLabel: UILabel!
    @IBOutlet weak var trackCoverImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var trackProgressSlider: UISlider!
    @IBOutlet weak var trackCurrentTimeLabel: UILabel!
    @IBOutlet weak var trackDurationLabel: UILabel!
    @IBOutlet weak var repeatButtonNonActive: UIButton!
    @IBOutlet weak var repeatButtonActive: UIButton!
    @IBOutlet weak var repeatOneTrackOnlyButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    var track: TrackDataStruct!
    let documentController = DocumentTableViewController.shared
    var email: String = ""
    var tracks = [PrimitiveTrackDataStruct]()
    
    var trackPlayer: AVAudioPlayer?
    var displayLink : CADisplayLink! = nil
    var counter = 0
    var trackListTemp = [String]()
    var trackShuffleTemp = [String]()
    var trackPlaylist = [String]()
    var repeatPlaylistBoolean = true
    var playAndPauseBoolean = false
    var miniTrackDelegate: MiniTrackPlayerDelegate?
    
    var favoriteBool: Bool {
        return favoriteButton.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadEmail = UserDefaults.standard.string(forKey: "email"){
            email = loadEmail
        }
        trackPlayerTitleLabel.text = NSLocalizedString("Now Playing".uppercased(), comment: "")
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        retreiveTrack()
        retreiveFavorites()
        prepareTrack()
        prepareAndCustomizeSlider()
        buttonStateChange()
        receiveButtonState(state: playAndPauseBoolean)
        trackDismiss()
    }
    
    func receiveButtonState(state: Bool?){
        playAndPauseButton.isSelected = state!
    }
    
    func trackDismiss(){
        if playAndPauseButton.isSelected == true{
            miniTrackDelegate?.miniTrackPlayerButtonState(state: true)
        }else{
            miniTrackDelegate?.miniTrackPlayerButtonState(state: false)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func changeFavourites() {
        let temp = PrimitiveTrackDataStruct(
            genre: track.genre,
            name: track.name,
            email: track.email
        )
        var counter = 0
        var flag = false
        for track in tracks {
            if track.name == self.track.name {
                flag = true
                tracks.remove(at: counter)
            }
            counter += 1
        }
        if !flag {
            tracks.append(temp)
        }
        
        documentController.uploadFavorite(id: email, track: tracks)
    }
    
    func retreiveFavorites() {
        /*
        documentController.getFavoritesFromCloudKit { (favourites) in
            for favourite in favourites {
                if self.email != "" && favourite.id == self.email {
                    self.tracks = favourite.track!
                }
            }
            print("current", self.tracks.count)
            for track in self.tracks {
                if track.name == self.track.name {
                    DispatchQueue.main.async {
                        self.favoriteButton.isSelected = !self.favoriteButton.isSelected
                    }
                }
            }
        }
 */
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
            let audioPath = track.fileData!.fileURL
            do {
                trackPlayer = try AVAudioPlayer(contentsOf: audioPath!)
                
            } catch let error1 as NSError {
                error = error1
            }
        }else {
            print("track nil")
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
        if trackPlayer?.isPlaying == true
        {
            trackProgressSlider.minimumValue = 0.0
            trackProgressSlider.maximumValue = Float(trackPlayer!.duration)
            trackProgressSlider.setValue(Float(trackPlayer!.currentTime), animated: true)
            
            let minute = Int(trackPlayer!.duration / 60)
            let second = Int(trackPlayer!.duration) - minute * 60
            
            trackCurrentTimeLabel.text = "\(minute):\(String(format: "%2d", second))"
        }
    }
    
    func buttonStateChange(){
        
        favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
        favoriteButton.setImage(#imageLiteral(resourceName: "HeartFill"), for: .selected)
        
        playAndPauseButton.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
        playAndPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .selected)
        
        shuffleButton.setImage(#imageLiteral(resourceName: "shuffle"), for: .normal)
        shuffleButton.setImage(#imageLiteral(resourceName: "shuffleActive"), for: .selected)
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
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true{
            trackPlayer!.play()
            playAndPauseButton.isSelected = true
        }else{
            trackPlayer!.pause()
            playAndPauseButton.isSelected = false
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
                    playAndPauseButton.isSelected = false
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
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true{
            shuffleButton.isSelected = true
            
            trackPlaylist.removeAll()
            trackPlaylist.append(contentsOf: trackListTemp)
            
            trackShuffleTemp.removeAll()
            trackShuffleTemp.append(contentsOf: trackListTemp)
            trackShuffleTemp.shuffle()
            trackPlaylist.removeAll()
            trackPlaylist.append(contentsOf: (trackShuffleTemp))
        }else{
            shuffleButton.isSelected = false
            
            trackPlaylist.removeAll()
            trackPlaylist.append(contentsOf: trackListTemp)
            
            trackShuffleTemp.removeAll()
            trackShuffleTemp.append(contentsOf: trackListTemp)
            trackShuffleTemp.shuffle()
            trackPlaylist.removeAll()
            trackPlaylist.append(contentsOf: (trackShuffleTemp))
        }
    }
    
    @IBAction func artistButton(_ sender: UIButton) {
        
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        changeFavourites()
        print(favoriteBool)
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        if playAndPauseButton.isSelected == true{
            miniTrackDelegate?.miniTrackPlayerButtonState(state: true)
        }else{
            miniTrackDelegate?.miniTrackPlayerButtonState(state: false)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        trackPlayer?.stop()
//        super .viewWillDisappear(animated)
//    }
}
