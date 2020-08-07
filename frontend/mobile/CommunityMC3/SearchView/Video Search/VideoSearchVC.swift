//
//  VideoSearchVC.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class VideoSearchVC: UIViewController {
    
    @IBOutlet weak var videoSearchTableView: UITableView!
    
    var dm:DataManager? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoSearchTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        videoSearchTableView.register(UINib(nibName: "VideoSearchCell", bundle: nil), forCellReuseIdentifier: "videoSearchCell")
        
        dm = DataManager.shared()
    }
    
}

extension VideoSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dm!.filteredVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoSearchTableView.dequeueReusableCell(withIdentifier: "videoSearchCell") as! VideoSearchCell
        cell.updateData(dm!.filteredVideos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
    }
    
}


