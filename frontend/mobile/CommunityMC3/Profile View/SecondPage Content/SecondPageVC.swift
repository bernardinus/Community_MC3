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
        showcaseTableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "musicTableCell")
        showcaseTableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "photosTableCell")
        showcaseTableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "videosTableCell")
    }
    
}

extension SecondPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "showcaseHeaderCell") as! ShowcaseHeaderCell
        if(section == ShowcaseSection.Music.rawValue)
        {
            cell.showcaseSectionHeader.text = NSLocalizedString("Music", comment: "")
        }
        if(section == ShowcaseSection.Photos.rawValue)
        {
            cell.showcaseSectionHeader.text = NSLocalizedString("Photos", comment: "")
        }
        if(section == ShowcaseSection.Videos.rawValue)
        {
            cell.showcaseSectionHeader.text = NSLocalizedString("Videos", comment: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ShowcaseSection.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == ShowcaseSection.Music.rawValue)
        {
            return 3
        }
        if(section == ShowcaseSection.Photos.rawValue)
        {
            return 1
        }
        if(section == ShowcaseSection.Videos.rawValue)
        {
            return 3
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == ShowcaseSection.Music.rawValue)
        {
            let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "musicTableCell") as! MusicTableViewCell
            return cell
        }
        if(indexPath.section == ShowcaseSection.Photos.rawValue)
        {
            let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "photosTableCell") as! PhotosTableViewCell
            return cell
        }
        if(indexPath.section == ShowcaseSection.Videos.rawValue)
        {
            let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "videosTableCell") as! VideosTableViewCell
            return cell
        }
        
        return showcaseTableView.dequeueReusableCell(withIdentifier: "musicTableCell")!

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == ShowcaseSection.Music.rawValue)
        {
            return 48
        }
        if(indexPath.section == ShowcaseSection.Photos.rawValue)
        {
            return 220
        }
        if(indexPath.section == ShowcaseSection.Videos.rawValue)
        {
            return 180
        }
        return 36
    }
    
    
}
