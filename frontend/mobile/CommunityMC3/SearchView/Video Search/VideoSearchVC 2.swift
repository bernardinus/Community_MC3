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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoSearchTableView.register(UINib(nibName: "VideoSearchCell", bundle: nil), forCellReuseIdentifier: "videoSearchCell")
        
    }
    
}

extension VideoSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoSearchTableView.dequeueReusableCell(withIdentifier: "videoSearchCell") as! VideoSearchCell
        return cell
    }
    
}


