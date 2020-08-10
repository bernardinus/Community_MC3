//
//  ShowcaseVideosVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ShowcaseVideosVC: UIViewController {
    
    @IBOutlet weak var showcaseVideoTableView: UITableView!
    
    var videoData:[VideosDataStruct]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showcaseVideoTableView.register(UINib(nibName: "VideosTableViewCell", bundle:nil), forCellReuseIdentifier: "videosTableCell")
        
    }
    
}

extension ShowcaseVideosVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(videoData != nil)
        {
            return videoData!.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showcaseVideoTableView.dequeueReusableCell(withIdentifier: "videosTableCell") as! VideosTableViewCell
        cell.update(videoData: videoData![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TrackManager.shared.playVideo(view: self, videoData: videoData![indexPath.row])
    }
    
}
