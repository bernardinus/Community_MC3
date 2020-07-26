//
//  TrendingNowVC.swift
//  CommunityMC3
//
//  Created by Theofani on 21/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class TrendingNowVC: UIViewController {

    @IBOutlet weak var trendingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingTableView.register(UINib(nibName: "TrendingNowCell", bundle:nil), forCellReuseIdentifier: "trendingNowCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""        
    }
    
}

extension TrendingNowVC: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trendingTableView.dequeueReusableCell(withIdentifier: "trendingNowCell") as! TrendingNowCell
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
