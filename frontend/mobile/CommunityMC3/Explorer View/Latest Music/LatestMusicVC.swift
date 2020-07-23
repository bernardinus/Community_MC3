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
    override func viewDidLoad() {
        super.viewDidLoad()
        latestMusicTableView.register(UINib(nibName: "LatestMusicCell", bundle: nil), forCellReuseIdentifier: "latestMusicCell")
    }

}

extension LatestMusicVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = latestMusicTableView.dequeueReusableCell(withIdentifier: "latestMusicCell") as! LatestMusicCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
