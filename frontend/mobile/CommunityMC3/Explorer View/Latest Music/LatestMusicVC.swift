//
//  LatestMusicVC.swift
//  CommunityMC3
//
//  Created by Theofani on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class LatestMusicVC: UIViewController {
    
    @IBOutlet weak var latestMusicTableView: UITableView!
    
    var uploads: [UploadedDataStruct]!
    var selectedRow = 0
    var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        latestMusicTableView.register(UINib(nibName: "LatestMusicCell", bundle: nil), forCellReuseIdentifier: "latestMusicCell")
        
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
//                trackPlayerPage.track = uploads[selectedRow].track
            }
        }
        if segue.identifier == "videoPlayerSegue" {
            if let videoPlayerPage = segue.destination as? VideoPlayerViewController {
//                videoPlayerPage.video = uploads[selectedRow].video
            }
        }
    }
    
}

extension LatestMusicVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if uploads != nil {
            return uploads.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = latestMusicTableView.dequeueReusableCell(withIdentifier: "latestMusicCell") as! LatestMusicCell
        cell.mainTableView = mainTableView
        cell.upload = uploads[indexPath.row]
        if uploads[indexPath.row].track != nil {
//            cell.trackTitleLabel.text = uploads[indexPath.row].track?.name
//            cell.artistNameLabel.text = uploads[indexPath.row].track?.email
            //            print("masuk ", cell.player)
            if cell.player {
                //                cell.playMusicButton.imageView?.image = UIImage(systemName: "pause.fill")
                cell.playMusicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }else{
                //                cell.playMusicButton.imageView?.image = UIImage(systemName: "play.fill")
                cell.playMusicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
        if uploads[indexPath.row].video != nil {
//            cell.trackTitleLabel.text = uploads[indexPath.row].video?.name
//            cell.artistNameLabel.text = uploads[indexPath.row].video?.email
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        if uploads[selectedRow].track != nil {
            self.performSegue(withIdentifier: "trackPlayerSegue", sender: nil)
        }
        if uploads[selectedRow].video != nil {
            self.performSegue(withIdentifier: "videoPlayerSegue", sender: nil)
        }
    }
}
