//
//  VideoPlayerViewController.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVKit
import CloudKit

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var videoThumbnailImageView: UIImageView!
    
    static let shared = VideoPlayerViewController()
    
    var video: VideosDataStruct!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        video.fileData = CKAsset(fileURL:retrieveVideo(video: video)!)
        loadThumbnail()
    }
    
    func retrieveVideo(video: VideosDataStruct?) -> URL? {
        if video != nil {
            let videoURL = video!.fileData?.fileURL!
            let videoData = NSData(contentsOf: videoURL! as URL)
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent(video!.name + ".mov", isDirectory: false) //This is where I messed up.
            
            FileManager.default.createFile(atPath: (destinationPath?.path)!, contents:videoData as Data?, attributes:nil)
            
            return destinationPath!
        }
        return video?.fileData?.fileURL
    }
    
    func loadThumbnail() {
        
        let urls: URL?
        
        if video != nil {
            urls = video.fileData?.fileURL
        }else {
            let videoUrl = Bundle.main.path(forResource: " ", ofType: "mp4")
            urls = URL(fileURLWithPath: videoUrl!)
        }
        
        //insert generateThumbnail function to imageView
        self.videoThumbnailImageView.image = generateThumbnail(path: urls!)
        
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
        let video:AVPlayer?
        
        if self.video != nil {
            let urls = self.video.fileData?.fileURL
            video = AVPlayer(url: urls!)
        }else {
            if let urlString = Bundle.main.path(forResource: " ", ofType: "mp4"){
                video = AVPlayer(url: URL(fileURLWithPath: urlString))
            }else{
                video = nil
            }
        }
        if video != nil {
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video!
            
            //enter video player mode
            self.present(videoPlayer, animated: true, completion: {
                video!.play()
            })
        }
    }
    
}
