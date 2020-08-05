//
//  TrendingNowVC.swift
//  CommunityMC3
//
//  Created by Theofani on 21/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class TrendingNowVC: UIViewController {
    
    @IBOutlet weak var trendingTableView: UITableView!
    
    var trendings: [FeaturedDataStruct]!
    var selectedRow = 0
    var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingTableView.register(UINib(nibName: "TrendingNowCell", bundle:nil), forCellReuseIdentifier: "trendingNowCell")
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
                trackPlayerPage.track = trendings[selectedRow].track
            }
        }
        if segue.identifier == "videoPlayerSegue" {
            if let videoPlayerPage = segue.destination as? VideoPlayerViewController {
                videoPlayerPage.video = trendings[selectedRow].video
            }
        }
    }
    
}

extension TrendingNowVC: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trendings != nil {
            return trendings.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trendingTableView.dequeueReusableCell(withIdentifier: "trendingNowCell") as! TrendingNowCell
        cell.mainTableView = mainTableView
        cell.updateData(trackData: DataManager.shared().trendingNow!.tracks[indexPath.row])
        /*
        cell.trending = trendings[indexPath.row]
        if trendings[indexPath.row].track != nil {
            cell.trackTitleLabel.text = trendings[indexPath.row].track?.name
            cell.artistNameLabel.text = trendings[indexPath.row].track?.email
            if cell.player {
                cell.playMusicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }else{
                cell.playMusicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
        if trendings[indexPath.row].video != nil {
            cell.trackTitleLabel.text = trendings[indexPath.row].video?.name
            cell.artistNameLabel.text = trendings[indexPath.row].video?.email
            //                cell.musicImageView.imageView?.image = videoController.generateThumbnail(path: uploads[indexPath.row].video!.fileURL)
        }
        */
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
