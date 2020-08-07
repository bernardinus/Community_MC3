//
//  AllSearchVC.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum SearchSection:Int{
    case Artist = 0
    case Music = 1
    case Video = 2
    case Playlist = 3
    case Count = 4
}

class AllSearchVC: UIViewController {
    
    @IBOutlet weak var allSearchTableView: UITableView!
    
    var dm:DataManager = DataManager.shared()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        allSearchTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        allSearchTableView.register(UINib(nibName: "SearchHeaderSection", bundle: nil), forCellReuseIdentifier: "searchHeaderSection")
        allSearchTableView.register(UINib(nibName: "MusicSearchCell", bundle: nil), forCellReuseIdentifier: "musicSearchCell")
        allSearchTableView.register(UINib(nibName: "ArtistSearchCell", bundle: nil), forCellReuseIdentifier: "artistSearchCell")
        allSearchTableView.register(UINib(nibName: "VideoSearchCell", bundle: nil), forCellReuseIdentifier: "videoSearchCell")
        allSearchTableView.register(UINib(nibName: "PlaylistSearchCell", bundle: nil), forCellReuseIdentifier: "playlistSearchCell")
        
        dm = DataManager.shared()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        allSearchTableView.reloadData()
        super.viewWillAppear(animated)
    }
    
}

extension AllSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = allSearchTableView.dequeueReusableCell(withIdentifier: "searchHeaderSection") as! SearchHeaderSection
        if(section == SearchSection.Artist.rawValue)
        {
            cell.searchHeaderLabel.text = NSLocalizedString("Artist", comment: "")
        }
        if(section == SearchSection.Music.rawValue)
        {
            cell.searchHeaderLabel.text = NSLocalizedString("Music".uppercased(), comment: "")
        }
        if(section == SearchSection.Video.rawValue)
        {
            cell.searchHeaderLabel.text = NSLocalizedString("Video".uppercased(), comment: "")
        }
        if(section == SearchSection.Playlist.rawValue)
        {
            cell.searchHeaderLabel.text = NSLocalizedString("Playlist", comment: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // (artist, music, video) SearchSection.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        max 5
        switch section {
        case SearchSection.Artist.rawValue:
            return min(5, dm.filteredArtist.count)
        case SearchSection.Video.rawValue:
            return min(5, dm.filteredVideos.count)
        case SearchSection.Music.rawValue:
            return min(5, dm.filteredTracks.count)
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == SearchSection.Artist.rawValue)
        {
            let cell = allSearchTableView.dequeueReusableCell(withIdentifier: "artistSearchCell") as! ArtistSearchCell
            cell.artistData = dm.filteredArtist[indexPath.row]
            return cell
        }
        if(indexPath.section == SearchSection.Music.rawValue)
        {
            let cell = allSearchTableView.dequeueReusableCell(withIdentifier: "musicSearchCell") as! MusicSearchCell
            cell.trackData = dm.filteredTracks[indexPath.row]
            return cell
        }
        if(indexPath.section == SearchSection.Video.rawValue)
        {
            let cell = allSearchTableView.dequeueReusableCell(withIdentifier: "videoSearchCell") as! VideoSearchCell
            cell.videoData = dm.filteredVideos[indexPath.row]
            return cell
        }
        if(indexPath.section == SearchSection.Playlist.rawValue)
        {
            let cell = allSearchTableView.dequeueReusableCell(withIdentifier: "playlistSearchCell") as! PlaylistSearchCell
            return cell
        }
        return allSearchTableView.dequeueReusableCell(withIdentifier: "artistSearchCell")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == SearchSection.Video.rawValue)
        {
            return 200
        }
        
        return 80
    }
    
}
