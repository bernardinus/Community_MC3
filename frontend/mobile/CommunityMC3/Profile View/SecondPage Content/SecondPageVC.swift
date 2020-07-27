//
//  SecondPageVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum ShowcaseSection:Int{
    case Music = 0
    case Photos = 1
    case Videos = 2
    case Count = 3
}

class SecondPageVC: UIViewController {

    @IBOutlet weak var showcaseTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showcaseTableView.register(UINib(nibName: "ShowcaseHeaderCell", bundle:nil), forCellReuseIdentifier: "showcaseHeaderCell")
    }
    
}

extension SecondPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "showcaseHeaderCell") as! ShowcaseHeaderCell
        if(section == ShowcaseSection.Music.rawValue)
        {
            cell.showcaseSectionHeader.text = NSLocalizedString("Music", comment: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        36
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ShowcaseSection.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == ShowcaseSection.Count.rawValue)
        {
            let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "musicTableCell") as! MusicTableViewCell
            return cell
        }
        
        return showcaseTableView.dequeueReusableCell(withIdentifier: "musicTableCell")!

    }
    
    
}
