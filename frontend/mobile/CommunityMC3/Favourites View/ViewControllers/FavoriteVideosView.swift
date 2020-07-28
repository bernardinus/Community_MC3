//
//  FavoriteVideosView.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVKit

class FavoriteVideosView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videoPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FavoriteVideosCell", bundle: nil), forCellReuseIdentifier: "favoriteVideosCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
    }
    
    @objc func clickPlayVideo(_ sender: UIButton){
        if let urlString = Bundle.main.path(forResource: "", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: urlString))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            //enter video player mode
            self.present(videoPlayer, animated: true, completion: {
                video.play()
                
            })
        }
    }
    
    @objc func favoriteButtonState(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        
        if sender.isSelected == false{
            let cell = tableView.cellForRow(at: selectedIndex) as! FavoriteVideosCell
            
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
            
            self.tableView.reloadData()
        }
    }
    
    func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 5, timescale: 1), actualTime: nil)
            let thumbNail = UIImage(cgImage: cgImage)
            return thumbNail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
    
}


extension FavoriteVideosView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteVideosCell", for: indexPath) as! FavoriteVideosCell
        
        cell.favoriteButton.setImage(#imageLiteral(resourceName: "HeartFill"), for: .selected)
        cell.favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonState(_:)), for: .touchUpInside)
        
        //            let videoUrl = Bundle.main.path(forResource: " ", ofType: "mp4")
        //            let urls = URL(fileURLWithPath: videoUrl!)
        
        cell.videoThumbnailImage.layer.borderWidth = 2
        //            cell.videoThumbnailImage.image = generateThumbnail(path: urls)
        
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(clickPlayVideo(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
}
