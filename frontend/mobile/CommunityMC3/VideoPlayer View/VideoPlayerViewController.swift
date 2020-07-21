//
//  VideoPlayerViewController.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var videoThumbnailImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadThumbnail()
    }
    
    func loadThumbnail() {
        let videoUrl = Bundle.main.path(forResource: " ", ofType: "mp4")
        let urls = URL(fileURLWithPath: videoUrl!)
        
        //insert generateThumbnail function to imageView
        self.videoThumbnailImageView.image = generateThumbnail(path: urls)

    }
    
    //function to generate video thumbnail
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

    
    @IBAction func playVideoButtonAction(_ sender: UIButton) {
        if let urlString = Bundle.main.path(forResource: " ", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: urlString))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            //enter video player mode
            self.present(videoPlayer, animated: true, completion: {
                video.play()
                
            })
        }
    }

}
