//
//  ShowcaseMusicVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ShowcaseMusicVC: UIViewController {

    @IBOutlet weak var showcaseMusicTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showcaseMusicTable.register(UINib(nibName: "MusicTableViewCell", bundle:nil), forCellReuseIdentifier: "musicTableCell")

    }
}

extension ShowcaseMusicVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showcaseMusicTable.dequeueReusableCell(withIdentifier: "musicTableCell") as! MusicTableViewCell
        return cell
    }
    
}
