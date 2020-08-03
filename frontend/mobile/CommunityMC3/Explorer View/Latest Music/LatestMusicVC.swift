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
                trackPlayerPage.track = uploads[selectedRow].trackData
            }
        }
        if segue.identifier == "videoPlayerSegue" {
            if let videoPlayerPage = segue.destination as? VideoPlayerViewController {
                videoPlayerPage.video = uploads[selectedRow].videoData
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
        cell.updateCellData(data: uploads[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        if(uploads[selectedRow].isVideo)
        {
            self.performSegue(withIdentifier: "videoPlayerSegue", sender: nil)
        }
        else
        {
            self.performSegue(withIdentifier: "trackPlayerSegue", sender: nil)
        }
    }
}
