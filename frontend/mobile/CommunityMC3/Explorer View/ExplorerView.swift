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
    case FeaturedVideos = 4
    case Count = 5
}

class ExplorerView: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var notificationsIconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainTableView.register(UINib(nibName: "TrendingNowCell", bundle:nil), forCellReuseIdentifier: "trendingNowCell")
        mainTableView.register(UINib(nibName: "HeaderCell", bundle:nil), forCellReuseIdentifier: "headerCell")
        mainTableView.register(UINib(nibName: "DiscoverNewCell", bundle:nil), forCellReuseIdentifier: "discoverNewCell")
        mainTableView.register(UINib(nibName: "LatestMusicCell", bundle:nil), forCellReuseIdentifier: "latestMusicCell")
        mainTableView.register(UINib(nibName: "FeaturedArtistCell", bundle:nil), forCellReuseIdentifier: "featuredArtistCell")
        mainTableView.register(UINib(nibName: "FeaturedVideosCell", bundle:nil), forCellReuseIdentifier: "featuredVideosCell")

    }

     

}

extension ExplorerView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == ExplorerSection.TrendingNow.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Trending Now"
            cell.seeMoreButton.setTitle("See more >", for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "trendingSegue", sender: nil)
            }
            return cell
        }
        if(section == ExplorerSection.DiscoverNew.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Discover New"
            cell.seeMoreButton.isHidden = true
            return cell
        }
        if(section == ExplorerSection.LatestMusic.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Latest Music"
            cell.seeMoreButton.setTitle("See more >", for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "latestMusicSegue", sender: nil)
            }
            return cell
        }
        if(section == ExplorerSection.FeaturedArtist.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Featured Artist"
            cell.seeMoreButton.setTitle("More artist >", for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "featuredArtistSegue", sender: nil)
            }
            return cell
        }
        if(section == ExplorerSection.FeaturedVideos.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Featured Videos"
            cell.seeMoreButton.setTitle("More videos >", for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "featuredVideoSegue", sender: nil)
            }
            return cell
        }
        
        return mainTableView.dequeueReusableCell(withIdentifier: "headerCell")!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        55
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
        if(section == ExplorerSection.FeaturedVideos.rawValue)
        {
            return 3 // Featured Videos
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
        if(indexPath.section == ExplorerSection.FeaturedVideos.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "featuredVideosCell") as! FeaturedVideosCell
            return cell
        }

        return mainTableView.dequeueReusableCell(withIdentifier: "trendingNowCell")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == ExplorerSection.TrendingNow.rawValue)
        {
            return 88
        }
        if(indexPath.section == ExplorerSection.DiscoverNew.rawValue)
        {
            return 140
        }
        if(indexPath.section == ExplorerSection.FeaturedArtist.rawValue)
        {
            return 160
        }
        if(indexPath.section == ExplorerSection.FeaturedVideos.rawValue)
        {
            return 160
        }
        return 110
    }

    
}
