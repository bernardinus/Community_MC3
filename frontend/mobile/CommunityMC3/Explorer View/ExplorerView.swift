//
//  FirstViewController.swift
//  CommunityMC3
//
//  Created by Bryanza on 06/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum ExplorerSection:Int {
    case TrendingNow = 0
    case DiscoverNew = 1
    case LatestMusic = 2
    case FeaturedArtist = 3
    case Count = 4
}

class ExplorerView: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainTableView.register(UINib(nibName: "TrendingNowCell", bundle:nil), forCellReuseIdentifier: "trendingNowCell")
        mainTableView.register(UINib(nibName: "HeaderCell", bundle:nil), forCellReuseIdentifier: "headerCell")
        mainTableView.register(UINib(nibName: "DiscoverNewCell", bundle:nil), forCellReuseIdentifier: "discoverNewCell")
        mainTableView.register(UINib(nibName: "LatestMusicCell", bundle:nil), forCellReuseIdentifier: "latestMusicCell")
        mainTableView.register(UINib(nibName: "FeaturedArtistCell", bundle:nil), forCellReuseIdentifier: "featuredArtistCell")

    }


}

extension ExplorerView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == ExplorerSection.TrendingNow.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Trending Now"
            return cell
        }
        if(section == ExplorerSection.DiscoverNew.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Discover New"
            return cell
        }
        if(section == ExplorerSection.LatestMusic.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Latest Music"
            return cell
        }
        if(section == ExplorerSection.LatestMusic.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Featured Artist"
            return cell
        }
        return mainTableView.dequeueReusableCell(withIdentifier: "headerCell")!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ExplorerSection.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == ExplorerSection.TrendingNow.rawValue)
        {
            return 3 // Trending Now
        }
        if(section == ExplorerSection.DiscoverNew.rawValue)
        {
            return 1 // Discover New
        }
        if(section == ExplorerSection.LatestMusic.rawValue)
        {
            return 3 // Latest Music
        }
        if(section == ExplorerSection.FeaturedArtist.rawValue)
        {
            return 1 // Featured Artist
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == ExplorerSection.TrendingNow.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "trendingNowCell") as! TrendingNowCell
            return cell
        }
        if(indexPath.section == ExplorerSection.DiscoverNew.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "discoverNewCell") as! DiscoverNewCell
            return cell
        }
        if(indexPath.section == ExplorerSection.LatestMusic.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "latestMusicCell") as! LatestMusicCell
            return cell
        }
        if(indexPath.section == ExplorerSection.FeaturedArtist.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "featuredArtistCell") as! FeaturedArtistCell
            return cell
        }

        return mainTableView.dequeueReusableCell(withIdentifier: "trendingNowCell")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    
}
