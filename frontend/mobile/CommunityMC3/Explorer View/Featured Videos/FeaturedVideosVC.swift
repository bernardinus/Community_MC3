//
//  FeaturedVideosVC.swift
//  CommunityMC3
//
//  Created by Theofani on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FeaturedVideosVC: UIViewController {
    
    
    var features: FeaturedDataStruct? = nil
    var selectedRow = 0
    var mainTableView: UITableView!
    
    @IBOutlet weak var featuredVideoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredVideoTableView.register(UINib(nibName: "FeaturedVideosCell", bundle: nil), forCellReuseIdentifier: "featuredVideosCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
        
    }
    
    // MARK: Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trackPlayerSegue" {
            if let trackPlayerPage = segue.destination as? TrackPlayerViewController {
//                trackPlayerPage.track = features[selectedRow].track
            }
        }
        if segue.identifier == "videoPlayerSegue" {
            if let videoPlayerPage = segue.destination as? VideoPlayerViewController {
//                videoPlayerPage.video = features[selectedRow].video
            }
        }
    }
}

extension FeaturedVideosVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if features != nil {
            return features!.videos.count
        }
        //        return 10
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuredVideoTableView.dequeueReusableCell(withIdentifier: "featuredVideosCell") as! FeaturedVideosCell
        cell.updateData(videoData: features!.videos[indexPath.row])
        
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super .viewWillDisappear(animated)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
//        if features[selectedRow].video != nil {
//            self.performSegue(withIdentifier: "videoPlayerSegue", sender: nil)
//        }
        TrackManager.shared.playVideo(view: self, videoData: features!.videos[indexPath.row])
    }
}
