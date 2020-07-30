//
//  FavoritesDetailView.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class FavoriteTracksView: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var trackPlayer: AVAudioPlayer?
    var playerTemp: AVAudioPlayer?
    var timer: Timer? = nil
    var seconds = 0
    var tempIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FavoriteTracksCell", bundle: nil), forCellReuseIdentifier: "favoriteTracksCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
    }
    
    
    @objc func directPlay(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        
        tempIndex = sender.tag
        
        let audioPath = Bundle.main.path(forResource: "", ofType: "mp3")!
        var error : NSError? = nil
        do {
            trackPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            
        } catch let error1 as NSError {
            error = error1
        }
        
        trackPlayer!.delegate = self
        timer?.invalidate()
        
        if sender.isSelected == true {
            if error == nil {
                trackPlayer?.delegate = self
                trackPlayer?.prepareToPlay()
                trackPlayer?.play()
            }
            let cell = tableView.cellForRow(at: selectedIndex) as! FavoriteTracksCell
            seconds = Int(trackPlayer!.duration)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.hour, .minute, .second]
                formatter.unitsStyle = .positional
                
                let formattedString = formatter.string(from: TimeInterval(self.seconds))!
                self.seconds -= 1
                cell.trackDurationLabel.text = "\(formattedString)"
            }
        }else if sender.isSelected == false{
            trackPlayer?.stop()
            timer!.invalidate()
        }
        tableView.reloadData()
    }
    
    @objc func favoriteButtonState(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        
        if sender.isSelected == false{
            let cell = tableView.cellForRow(at: selectedIndex) as! FavoriteTracksCell
            
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
            
            self.tableView.reloadData()
        }
    }
    
}

extension FavoriteTracksView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTracksCell", for: indexPath) as! FavoriteTracksCell
        cell.playButton.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        
        cell.playButton.setImage(#imageLiteral(resourceName: "playButtonFavorites"), for: .normal)
        cell.playButton.setImage(#imageLiteral(resourceName: "StopButtonFavorite"), for: .selected)
        cell.playButton.addTarget(self, action: #selector(directPlay(_:)), for: .touchUpInside)
        
        cell.favoriteButton.setImage(#imageLiteral(resourceName: "HeartFill"), for: .selected)
        cell.favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonState(_:)), for: .touchUpInside)
        
        cell.trackCoverImage.image = #imageLiteral(resourceName: "music-image-dummy1")
        
        if indexPath.row == tempIndex{
            
        }else{
            cell.playButton.isSelected = false
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toTrackPlayer", sender: self)
//    }
}
