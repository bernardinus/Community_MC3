//
//  PlaylistSearchVC.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class PlaylistSearchVC: UIViewController {
    
    @IBOutlet weak var playlistSearchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playlistSearchTableView.register(UINib(nibName: "PlaylistSearchCell", bundle: nil), forCellReuseIdentifier: "playlistSearchCell")
    }
    
}

extension PlaylistSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistSearchTableView.dequeueReusableCell(withIdentifier: "playlistSearchCell") as! PlaylistSearchCell
        return cell
    }
    
}
