//
//  MusicSearchVC.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MusicSearchVC: UIViewController {

    @IBOutlet weak var musicSearchTableView: UITableView!
    
    var dm:DataManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        musicSearchTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        musicSearchTableView.register(UINib(nibName: "MusicSearchCell", bundle: nil), forCellReuseIdentifier: "musicSearchCell")
        
        dm = DataManager.shared()
    }
    
}

extension MusicSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dm!.filteredTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicSearchTableView.dequeueReusableCell(withIdentifier: "musicSearchCell") as! MusicSearchCell
        cell.updateData(dm!.filteredTracks[indexPath.row])
        return cell
    }
    
}
