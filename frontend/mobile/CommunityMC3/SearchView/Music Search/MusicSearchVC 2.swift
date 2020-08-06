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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicSearchTableView.register(UINib(nibName: "MusicSearchCell", bundle: nil), forCellReuseIdentifier: "musicSearchCell")
    }
    
}

extension MusicSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicSearchTableView.dequeueReusableCell(withIdentifier: "musicSearchCell") as! MusicSearchCell
        return cell
    }
    
}
