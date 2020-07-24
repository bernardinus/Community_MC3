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
    
    var tracks: [TrackDataStruct]!
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        latestMusicTableView.register(UINib(nibName: "LatestMusicCell", bundle: nil), forCellReuseIdentifier: "latestMusicCell")
        
    }
    
    // MARK: Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trackPlayerSegue" {
            if let trackPlayerPage = segue.destination as? TrackPlayerViewController {
               trackPlayerPage.track = tracks[selectedRow]
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        super .viewWillDisappear(animated)
    }


}

extension LatestMusicVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tracks != nil {
            return tracks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = latestMusicTableView.dequeueReusableCell(withIdentifier: "latestMusicCell") as! LatestMusicCell
        cell.trackTitleLabel.text = tracks[indexPath.row].name
        cell.artistNameLabel.text = tracks[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "trackPlayerSegue", sender: nil)
    }
}
