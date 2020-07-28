//
//  ShowcaseVideosVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ShowcaseVideosVC: UIViewController {
    
    @IBOutlet weak var showcaseVideoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showcaseVideoTableView.register(UINib(nibName: "VideosTableViewCell", bundle:nil), forCellReuseIdentifier: "videosTableCell")
        
    }
    
}

extension ShowcaseVideosVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showcaseVideoTableView.dequeueReusableCell(withIdentifier: "videosTableCell") as! VideosTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
