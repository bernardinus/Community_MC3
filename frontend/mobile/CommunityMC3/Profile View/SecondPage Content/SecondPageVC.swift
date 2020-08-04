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
    
    var showcaseMusicSegue: (() -> Void)? = nil
    var showcasePhotoSegue: (() -> Void)? = nil
    var showcaseVideoSegue: (() -> Void)? = nil
    var playMusicSegue: ((Any?) -> Void)? = nil
    var playVideoSegue: ((Any?) -> Void)? = nil
    
    
    var tracks:[TrackDataStruct]? = []
    var videos:[VideosDataStruct]? = []
    var photos:[PhotoDataStruct]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showcaseTableView.register(UINib(nibName: "ShowcaseHeaderCell", bundle:nil), forCellReuseIdentifier: "showcaseHeaderCell")
        showcaseTableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "musicTableCell")
        showcaseTableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "photosTableCell")
        showcaseTableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "videosTableCell")
    }
    
    func updateData(tracks:[TrackDataStruct]?, videos:[VideosDataStruct]?, photos:[PhotoDataStruct]?)
    {
        self.tracks = tracks
        self.videos = videos
        self.photos = photos
        
        print("\(tracks?.count) \(videos?.count) \(photos?.count)")
        if(showcaseTableView != nil)
        {
            showcaseTableView.reloadData()
        }
        
    }
}

extension SecondPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "showcaseHeaderCell") as! ShowcaseHeaderCell
        if(section == ShowcaseSection.Music.rawValue)
        {
            cell.showcaseSectionHeader.text = NSLocalizedString("Music".uppercased(), comment: "")
            cell.callBack = {
                self.showcaseMusicSegue!()
            }
        }
        if(section == ShowcaseSection.Photos.rawValue)
        {
            cell.showcaseSectionHeader.text = NSLocalizedString("Photos".uppercased(), comment: "")
            cell.callBack = {
                self.showcasePhotoSegue!()
            }
        }
        if(section == ShowcaseSection.Videos.rawValue)
        {
            cell.showcaseSectionHeader.text = NSLocalizedString("Videos".uppercased(), comment: "")
            cell.callBack = {
                self.showcaseVideoSegue!()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == ShowcaseSection.Music.rawValue)
        {
            playMusicSegue!(tracks![indexPath.row])
        }
        if(indexPath.section == ShowcaseSection.Videos.rawValue)
        {
            playVideoSegue!(videos![indexPath.row])
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ShowcaseSection.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == ShowcaseSection.Music.rawValue)
        {
            return min(tracks!.count,3)
        }
        if(section == ShowcaseSection.Photos.rawValue)
        {
            return 1
        }
        if(section == ShowcaseSection.Videos.rawValue)
        {
            return min(videos!.count,3)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == ShowcaseSection.Music.rawValue)
        {
            let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "musicTableCell") as! MusicTableViewCell
            cell.updateData(track: tracks![indexPath.row])
            return cell
        }
        if(indexPath.section == ShowcaseSection.Photos.rawValue)
        {
            let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "photosTableCell") as! PhotosTableViewCell
//            cell.updateData(photosData: photos!)
            return cell
        }
        if(indexPath.section == ShowcaseSection.Videos.rawValue)
        {
            let cell = showcaseTableView.dequeueReusableCell(withIdentifier: "videosTableCell") as! VideosTableViewCell
            cell.update(videoData: videos![indexPath.row])
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let footerView = UIView()
            let footerChildView = UIView(frame: CGRect(x: 60, y: 0, width: tableView.frame.width - 60, height: 0.5))
    //        footerChildView.backgroundColor = UIColor.darkGray
            footerView.addSubview(footerChildView)
            return footerView
        }
    
    
}
