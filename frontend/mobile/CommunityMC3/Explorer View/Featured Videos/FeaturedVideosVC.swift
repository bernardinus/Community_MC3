//
//  FeaturedVideosVC.swift
//  CommunityMC3
//
//  Created by Theofani on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FeaturedVideosVC: UIViewController {
 
    
    var features: [FeaturedDataStruct]!
    
    @IBOutlet weak var featuredVideoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredVideoTableView.register(UINib(nibName: "FeaturedVideosCell", bundle: nil), forCellReuseIdentifier: "featuredVideosCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""

    }
}

extension FeaturedVideosVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if features != nil {
            return features.count
        }
//        return 10
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuredVideoTableView.dequeueReusableCell(withIdentifier: "featuredVideosCell") as! FeaturedVideosCell
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super .viewWillDisappear(animated)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
