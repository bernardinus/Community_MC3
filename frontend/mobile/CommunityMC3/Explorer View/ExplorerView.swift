//
//  FirstViewController.swift
//  CommunityMC3
//
//  Created by Bryanza on 06/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import BonsaiController
import CloudKit

enum ExplorerSection:Int {
    case TrendingNow = 0
    case DiscoverNew = 1
    case LatestMusic = 2
    case FeaturedArtist = 3
    case FeaturedVideos = 4
    case Count = 5
}

private enum TransitionType {
    case none
    case bubble
    case slide(fromDirection: Direction)
    case menu(fromDirection: Direction)
}

class ExplorerView: UIViewController {
    
    @IBOutlet weak var ExploreTitleLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var notificationsIconImage: UIImageView!
    
    let documentController = DocumentTableViewController.shared
    let videoController = VideoPlayerViewController.shared
    let uploadController = UploadController.shared
    let userDefault = UserDefaults.standard
    //    var tracks = [TrackDataStruct]()
    //    var videos = [VideosDataStruct]()
    var uploads = [UploadedDataStruct]()
    var features = [FeaturedDataStruct]()
    var trendings = [FeaturedDataStruct]()
    var artistCount = 0
    var uploadCount = 0
    var selectedRow = 0
    var selectUpload = false
    var selectFeatured = false
    var selectTrending = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        ExploreTitleLabel.text = NSLocalizedString("Explore", comment: "")
        
        
        // Do any additional setup after loading the view.
        
        mainTableView.register(UINib(nibName: "TrendingNowCell", bundle:nil), forCellReuseIdentifier: "trendingNowCell")
        mainTableView.register(UINib(nibName: "HeaderCell", bundle:nil), forCellReuseIdentifier: "headerCell")
        mainTableView.register(UINib(nibName: "DiscoverNewCell", bundle:nil), forCellReuseIdentifier: "discoverNewCell")
        mainTableView.register(UINib(nibName: "LatestMusicCell", bundle:nil), forCellReuseIdentifier: "latestMusicCell")
        mainTableView.register(UINib(nibName: "FeaturedArtistCell", bundle:nil), forCellReuseIdentifier: "featuredArtistCell")
        mainTableView.register(UINib(nibName: "FeaturedVideosCell", bundle:nil), forCellReuseIdentifier: "featuredVideosCell")
        mainTableView.canCancelContentTouches = true
        //        mainTableView.delaysContentTouches = true;
        
        hightlightUpload()
        featuredCombine()
        //        latestUpload()
        
    }
    
    func passTabData() {
        let favoriteTab = self.tabBarController?.viewControllers![2] as! FavouritesView
        favoriteTab.uploads = DataManager.shared().latestUpload
    }
    
    func hightlightUpload() {
        uploadController.getTracksFromCloudKit(tableView: mainTableView) { (tracks) in
            for track in tracks {
                //                let temp = FeaturedDataStruct (
                //                    id: track.recordID,
                //                    track: track
                //                )
                //                self.trendings.append(temp)
                //                self.features.append(temp)
                //                self.uploadCount += 1
            }
        }
        documentController.getFilmsFromCloudKit { (videos) in
            for video in videos {
                let temp = FeaturedDataStruct (
                    id: video.recordID,
                    video: VideosDataStruct (
                        genre: (video.value(forKey: "genre") as? String)!,
                        name: (video.value(forKey: "name") as? String)!,
                        email: (video.value(forKey: "email") as? String)!,
                        fileURL: (video.value(forKey: "fileData") as? CKAsset)!.fileURL!
                    )
                )
                self.trendings.append(temp)
                self.features.append(temp)
                self.uploadCount += 1
            }
        }
    }
    
    func featuredCombine() {
        documentController.getProfilesFromCloudKit { (photos) in
            for photo in photos {
                let asset = (photo.value(forKey: "fileData") as? CKAsset)!
                let temp = FeaturedDataStruct (
                    id: photo.recordID,
                    user: UserDataStruct(
                        genre: (photo.value(forKey: "genre") as? String)!,
                        name: (photo.value(forKey: "name") as? String)!,
                        fileURL: asset.fileURL!,
                        email: (photo.value(forKey: "email") as? String)!
                    )
                )
                self.features.append(temp)
                self.artistCount += 1
            }
        }
    }
    
    /*
     func latestUpload() {
     documentController.getUploadsFromCloudKit(tableView: mainTableView) { (tracks) in
     //            self.tracks = tracks
     for track in tracks {
     let temp = UploadedDataStruct (
     uploadedDate: track.creationDate!,
     track: TrackDataStruct (
     genre: (track.value(forKey: "genre") as? String)!,
     name: (track.value(forKey: "name") as? String)!,
     recordID: track.recordID,
     email: (track.value(forKey: "email") as? String)!,
     fileURL: (track.value(forKey: "fileData") as? CKAsset)!.fileURL!
     )
     )
     self.uploads.append(temp)
     }
     //            print("count ", tracks.count)
     }
     
     documentController.getFilmsFromCloudKit { (videos) in
     //            self.videos = videos
     for video in videos {
     let temp = UploadedDataStruct (
     uploadedDate: video.creationDate!,
     video: VideosDataStruct (
     genre: (video.value(forKey: "genre") as? String)!,
     name: (video.value(forKey: "name") as? String)!,
     email: (video.value(forKey: "email") as? String)!,
     fileURL: (video.value(forKey: "fileData") as? CKAsset)!.fileURL!
     )
     )
     //                let tmp = self.videoController.retrieveVideo(video: temp.video)!
     //                temp.video?.fileURL = tmp
     self.uploads.append(temp)
     }
     }
     
     //        self.uploads = self.uploads.sorted(by: { $0.uploadedDate.compare($1.uploadedDate) == .orderedDescending })
     
     }
     */
    
    
    
    @IBAction func accountButtonTouched(_ sender: Any)
    {
        if DataManager.shared().IsUserLogin() {
            self.performSegue(withIdentifier: "userProfileSegue", sender: nil)
        }else{
            self.performSegue(withIdentifier: "loginScreenSegue", sender: nil)
        }
    }
    
    @IBAction func notificationButtonTouched(_ sender: Any)
    {
        //        self.performSegue(withIdentifier: "notificationScreenSegue", sender: nil)
        print("openInstagram")
        openInstagram(username: "ubmuniversity")
    }
    
    @IBAction func unwindToExplorerView(_ segue:UIStoryboardSegue)
    {
        
    }
    
    
    private var transitionType: TransitionType = .none
    private func showSmallVC(transition: TransitionType)
    {
        
        transitionType = transition
        let sb = UIStoryboard(name: "SmallViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare Segue \(segue.identifier)")
        if segue.identifier == "trendingSegue" {
            if let trendingPage = segue.destination as? TrendingNowVC {
                var temp = [FeaturedDataStruct]()
                for trending in trendings {
                    temp.append(trending)
                }
                trendingPage.trendings = temp
                trendingPage.mainTableView = mainTableView
            }
        }
        else if segue.identifier == "featuredArtistSegue" {
            if let artistPage = segue.destination as? FeaturedArtistVC {
                var temp = [FeaturedDataStruct]()
                for feature in features {
                    if feature.user != nil {
                        temp.append(feature)
                    }
                }
                artistPage.features = temp
            }
        }
        else if segue.identifier == "featuredVideoSegue" {
            if let featuredPage = segue.destination as? FeaturedVideosVC {
                var temp = [FeaturedDataStruct]()
                for feature in features {
                    if feature.user == nil {
                        temp.append(feature)
                    }
                }
                featuredPage.features = temp
                featuredPage.mainTableView = mainTableView
            }
        }
        else if segue.identifier == "latestMusicSegue" {
            //            print("masuk ", tracks.count)
            //            let navPage = segue.destination as! UINavigationController
            //            let latestMusicPage = navPage.topViewController as! LatestMusicVC
            if let latestMusicPage = segue.destination as? LatestMusicVC {
                latestMusicPage.uploads = uploads
                latestMusicPage.mainTableView = mainTableView
            }
        }
        else if segue.identifier == "trackPlayerSegue" {
            if let trackPlayerPage = segue.destination as? TrackPlayerViewController {
                if selectUpload {
                    selectUpload = false
                    //                    trackPlayerPage.track = uploads[selectedRow].track
                }else if selectTrending {
                    selectTrending = false
                    trackPlayerPage.track = trendings[selectedRow].track
                }else {
                    selectFeatured = false
                    trackPlayerPage.track = features[selectedRow].track
                }
            }
        }
        else if segue.identifier == "videoPlayerSegue" {
            if let videoPlayerPage = segue.destination as? VideoPlayerViewController {
                if selectUpload {
                    selectUpload = false
                    //                    videoPlayerPage.video = uploads[selectedRow].video
                }else if selectTrending {
                    selectTrending = false
                    videoPlayerPage.video = trendings[selectedRow].video
                }else {
                    selectFeatured  = false
                    videoPlayerPage.video = features[selectedRow].video
                }
            }
        }
        else if segue.identifier == "loginScreenSegue"
        {
            let loginView = segue.destination as! LoginController
            loginView.callBack = {
                self.performSegue(withIdentifier: "userProfileSegue", sender: nil)
                
            }
        }
        else if segue.destination is SmallViewController {
            transitionType = .slide(fromDirection: .bottom)
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
        else
        {
            
            //            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.shadowImage = nil
        super.viewWillAppear(true)
    }
    
    
}

// MARK:- BonsaiController Delegate
extension ExplorerView: BonsaiControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        var blurEffectStyle = UIBlurEffect.Style.dark
        
        if #available(iOS 13.0, *) {
            blurEffectStyle = .systemChromeMaterial
        }
        
        let backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        switch transitionType {
        case .none:
            return nil
            
        case .bubble:
            
            //            // With Blur Style
            //            // return BonsaiController(fromView: popButton, blurEffectStyle: blurEffectStyle,  presentedViewController: presented, delegate: self)
            //
            //            // With Background Color
            //            return BonsaiController(fromView: popButton, backgroundColor: backgroundColor, presentedViewController: presented, delegate: self)
            return nil
            
        case .slide(let fromDirection), .menu(let fromDirection):
            
            // With Blur Style
            // return BonsaiController(fromDirection: fromDirection, blurEffectStyle: blurEffectStyle, presentedViewController: presented, delegate: self)
            
            // With Background Color
            return BonsaiController(fromDirection: fromDirection, backgroundColor: backgroundColor, presentedViewController: presented, delegate: self)
        }
    }
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        switch transitionType {
        case .none:
            return CGRect(origin: .zero, size: containerViewFrame.size)
        case .slide:
            return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
        case .bubble:
            return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / 2))
        case .menu(let fromDirection):
            var origin = CGPoint.zero
            if fromDirection == .right {
                origin = CGPoint(x: containerViewFrame.width / 2, y: 0)
            }
            return CGRect(origin: origin, size: CGSize(width: containerViewFrame.width / 2, height: containerViewFrame.height))
        }
    }
    
    func didDismiss() {
        print("didDismiss")
    }
}

extension ExplorerView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        if(section == ExplorerSection.TrendingNow.rawValue)
        {
            cell.HeaderName.text = NSLocalizedString("Trending Now", comment: "")
            cell.HeaderName.textColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0.2509803922, alpha: 1)
            cell.sectionBlock.backgroundColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0.2509803922, alpha: 1)
            cell.seeMoreButton.setTitle(NSLocalizedString("See more >", comment: ""), for: .normal)
            cell.seeMoreButton.setTitleColor(UIColor.white, for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "trendingSegue", sender: nil)
            }
            cell.headerBackgroundView.layer.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0, blue: 0.7843137255, alpha: 1)
        }
        else if(section == ExplorerSection.DiscoverNew.rawValue)
        {
            cell.HeaderName.text = NSLocalizedString("Discover New", comment: "")
            cell.seeMoreButton.isHidden = true
        }
        else if(section == ExplorerSection.LatestMusic.rawValue)
        {
            cell.HeaderName.text = NSLocalizedString("Latest Upload", comment: "")
            cell.seeMoreButton.setTitle(NSLocalizedString("See more >", comment: ""), for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "latestMusicSegue", sender: nil)
            }
        }
        else if(section == ExplorerSection.FeaturedArtist.rawValue)
        {
            cell.HeaderName.text = NSLocalizedString("Featured Artist", comment: "")
            cell.seeMoreButton.setTitle(NSLocalizedString("More artist >", comment: ""), for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "featuredArtistSegue", sender: nil)
            }
        }
        else if(section == ExplorerSection.FeaturedVideos.rawValue)
        {
            cell.HeaderName.text = NSLocalizedString("Featured Upload", comment: "")
            cell.seeMoreButton.setTitle(NSLocalizedString("More videos >", comment: ""), for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "featuredVideoSegue", sender: nil)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ExplorerSection.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == ExplorerSection.TrendingNow.rawValue)
        {
            return trendings.count // Trending Now
        }
        if(section == ExplorerSection.DiscoverNew.rawValue)
        {
            return 1 // Discover New
        }
        if(section == ExplorerSection.LatestMusic.rawValue)
        {
            //            return 3 // Latest Music
            //            print("hitung ", tracks.count)
            return uploads.count
        }
        if(section == ExplorerSection.FeaturedArtist.rawValue)
        {
            return artistCount // Featured Artist // 1
        }
        if(section == ExplorerSection.FeaturedVideos.rawValue)
        {
            return uploadCount // Featured Videos // 3
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == ExplorerSection.TrendingNow.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "trendingNowCell") as! TrendingNowCell
            cell.mainTableView = mainTableView
            cell.trending = trendings[indexPath.row]
            if trendings[indexPath.row].track != nil {
                cell.trackTitleLabel.text = trendings[indexPath.row].track?.name
                cell.artistNameLabel.text = trendings[indexPath.row].track?.email
                if cell.player {
                    cell.playMusicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                }else{
                    cell.playMusicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                }
            }
            if trendings[indexPath.row].video != nil {
                cell.trackTitleLabel.text = trendings[indexPath.row].video?.name
                cell.artistNameLabel.text = trendings[indexPath.row].video?.email
                //                cell.musicImageView.imageView?.image = videoController.generateThumbnail(path: uploads[indexPath.row].video!.fileURL)
            }
            return cell
        }
        if(indexPath.section == ExplorerSection.DiscoverNew.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "discoverNewCell") as! DiscoverNewCell
            cell.callBack = {
                self.performSegue(withIdentifier: "randomSpotlightSegue", sender: nil)
            }
            return cell
        }
        if(indexPath.section == ExplorerSection.LatestMusic.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "latestMusicCell") as! LatestMusicCell
            cell.mainTableView = mainTableView
            cell.upload = uploads[indexPath.row]
            if uploads[indexPath.row].track != nil {
                //                cell.trackTitleLabel.text = uploads[indexPath.row].track?.name
                //                cell.artistNameLabel.text = uploads[indexPath.row].track?.email
                //            print("masuk ", cell.player)
                if cell.player {
                    //                cell.playMusicButton.imageView?.image = UIImage(systemName: "pause.fill")
                    cell.playMusicButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                }else{
                    //                cell.playMusicButton.imageView?.image = UIImage(systemName: "play.fill")
                    cell.playMusicButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                }
            }
            if uploads[indexPath.row].video != nil {
                //                cell.trackTitleLabel.text = uploads[indexPath.row].video?.name
                //                cell.artistNameLabel.text = uploads[indexPath.row].video?.email
                //                cell.musicImageView.imageView?.image = videoController.generateThumbnail(path: uploads[indexPath.row].video!.fileURL)
            }
            return cell
        }
        if(indexPath.section == ExplorerSection.FeaturedArtist.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "featuredArtistCell") as! FeaturedArtistCell
            cell.callBack = {self.performSegue(withIdentifier: "artistPageSegue", sender: nil)}
            var temp = [FeaturedDataStruct]()
            for feature in features {
                if feature.user != nil {
                    temp.append(feature)
                }
            }
            cell.features = temp
            return cell
        }
        if(indexPath.section == ExplorerSection.FeaturedVideos.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "featuredVideosCell") as! FeaturedVideosCell
            if features[indexPath.row].track != nil {
                cell.mainTableView = mainTableView
                cell.feature = features[indexPath.row]
                if cell.player {
                    cell.videoPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                }else{
                    cell.videoPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                }
            }
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
            return 80
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        selectRow = indexPath.row
        //        self.performSegue(withIdentifier: "uploadTest", sender: self)
        if(indexPath.section == ExplorerSection.TrendingNow.rawValue)
        {
            selectedRow = indexPath.row
            selectTrending = true
            if trendings[selectedRow].video != nil {
                self.performSegue(withIdentifier: "videoPlayerSegue", sender: nil)
            }
            if trendings[selectedRow].track != nil {
                self.performSegue(withIdentifier: "trackPlayerSegue", sender: nil)
            }
        }
        if(indexPath.section == ExplorerSection.DiscoverNew.rawValue)
        {
        }
        if(indexPath.section == ExplorerSection.LatestMusic.rawValue)
        {
            selectedRow = indexPath.row
            selectUpload = true
            if uploads[selectedRow].video != nil {
                self.performSegue(withIdentifier: "videoPlayerSegue", sender: nil)
            }
            if uploads[selectedRow].track != nil {
                self.performSegue(withIdentifier: "trackPlayerSegue", sender: nil)
            }
        }
        if(indexPath.section == ExplorerSection.FeaturedArtist.rawValue)
        {
        }
        if(indexPath.section == ExplorerSection.FeaturedVideos.rawValue)
        {
            selectedRow = indexPath.row
            selectFeatured = true
            if features[selectedRow].video != nil {
                self.performSegue(withIdentifier: "videoPlayerSegue", sender: nil)
            }
            if features[selectedRow].track != nil {
                self.performSegue(withIdentifier: "trackPlayerSegue", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let footerChildView = UIView(frame: CGRect(x: 60, y: 0, width: tableView.frame.width - 60, height: 0.5))
        //        footerChildView.backgroundColor = UIColor.darkGray
        footerView.addSubview(footerChildView)
        return footerView
    }
    
}
