//
//  TrackManager.swift
//  Allegro
//
//  Created by Rommy Julius Dwidharma on 07/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class TrackManager {
    
    static let shared = TrackManager()
    weak var delegate: MiniTrackPlayerDelegate?
    
    init() {
        print("TrackManagerInit")
    }
    
    func play(trackData: TrackDataStruct){
        delegate?.play(data: trackData)
    }
    
    func stop() {
        delegate?.stop()
    }
    func pause(){
        delegate?.pause()
    }
    
    // to play videos in new view controller
    func playVideo(view:UIViewController, videoData:VideosDataStruct)
    {
        let URL = saveVideoToLocalData(video: videoData)
        let playerItem:AVPlayerItem = AVPlayerItem.init(url: URL!)
        let video:AVPlayer? = AVPlayer(url: URL!)
        video?.allowsExternalPlayback = true
        if video != nil {
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video!
            
            //enter video player mode
            view.present(videoPlayer, animated: true, completion: {
                video!.play()
            })
        }
    }

    func saveVideoToLocalData(video: VideosDataStruct?) -> URL?
    {
        if video != nil {
            let videoURL = video!.fileData?.fileURL!
            let videoData = NSData(contentsOf: videoURL! as URL)
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
            let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("cache" + ".mp4", isDirectory: false)
            
            FileManager.default.createFile(atPath: (destinationPath?.path)!, contents:videoData as Data?, attributes:nil)
            
            return destinationPath!
        }
        return nil
    }
}
