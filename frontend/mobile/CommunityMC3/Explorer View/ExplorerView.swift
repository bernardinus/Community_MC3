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

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var notificationsIconImage: UIImageView!
    
    let documentController = DocumentTableViewController.shared
    let videoController = VideoPlayerViewController.shared
//    var tracks = [TrackDataStruct]()
//    var videos = [VideosDataStruct]()
    var uploads = [UploadedDataStruct]()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Do any additional setup after loading the view.
        
        mainTableView.register(UINib(nibName: "TrendingNowCell", bundle:nil), forCellReuseIdentifier: "trendingNowCell")
        mainTableView.register(UINib(nibName: "HeaderCell", bundle:nil), forCellReuseIdentifier: "headerCell")
        mainTableView.register(UINib(nibName: "DiscoverNewCell", bundle:nil), forCellReuseIdentifier: "discoverNewCell")
        mainTableView.register(UINib(nibName: "LatestMusicCell", bundle:nil), forCellReuseIdentifier: "latestMusicCell")
        mainTableView.register(UINib(nibName: "FeaturedArtistCell", bundle:nil), forCellReuseIdentifier: "featuredArtistCell")
        mainTableView.register(UINib(nibName: "FeaturedVideosCell", bundle:nil), forCellReuseIdentifier: "featuredVideosCell")
        
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
                var temp = UploadedDataStruct (
                    uploadedDate: video.creationDate!,
                    video: VideosDataStruct (
                        genre: (video.value(forKey: "genre") as? String)!,
                        name: (video.value(forKey: "name") as? String)!,
                        email: (video.value(forKey: "email") as? String)!,
                        fileURL: (video.value(forKey: "fileData") as? CKAsset)!.fileURL!
                    )
                )
                let tmp = self.videoController.retrieveVideo(video: temp.video)!
                temp.video?.fileURL = tmp
                self.uploads.append(temp)
            }
        }

        
    }
    
    
    
    @IBAction func accountButtonTouched(_ sender: Any)
    {
        self.performSegue(withIdentifier: "loginScreenSegue", sender: nil)
    }
    
    @IBAction func notificationButtonTouched(_ sender: Any)
    {
        self.performSegue(withIdentifier: "notificationScreenSegue", sender: nil)
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
        print("Prepare Segue")
        if segue.identifier == "latestMusicSegue" {
//            print("masuk ", tracks.count)
            let navPage = segue.destination as! UINavigationController
            let latestMusicPage = navPage.topViewController as! LatestMusicVC
            latestMusicPage.uploads = uploads
            latestMusicPage.mainTableView = mainTableView
        }
        if segue.identifier == "trackPlayerSegue" {
            if let trackPlayerPage = segue.destination as? TrackPlayerViewController {
                trackPlayerPage.track = uploads[selectedRow].track
            }
        }
        if segue.identifier == "videoPlayerSegue" {
            if let videoPlayerPage = segue.destination as? VideoPlayerViewController {
                videoPlayerPage.video = uploads[selectedRow].video
            }
        }
        if segue.destination is SmallViewController {
            transitionType = .slide(fromDirection: .bottom)
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
        else
        {
            
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        if(section == ExplorerSection.TrendingNow.rawValue)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
            cell.HeaderName.text = "Trending Now"
            cell.HeaderName.textColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0.2509803922, alpha: 1)
            cell.sectionBlock.backgroundColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0.2509803922, alpha: 1)
            cell.seeMoreButton.setTitle("See more >", for: .normal)
            cell.seeMoreButton.setTitleColor(UIColor.white, for: .normal)
            cell.callBack = {
                self.performSegue(withIdentifier: "trendingSegue", sender: nil)
            }
            cell.headerBackgroundView.layer.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0, blue: 0.7843137255, alpha: 1)
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
//            return 3 // Latest Music
//            print("hitung ", tracks.count)
            return uploads.count
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
            cell.mainTableView = mainTableView
            cell.upload = uploads[indexPath.row]
            if uploads[indexPath.row].track != nil {
                cell.trackTitleLabel.text = uploads[indexPath.row].track?.name
                cell.artistNameLabel.text = uploads[indexPath.row].track?.email
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
                cell.trackTitleLabel.text = uploads[indexPath.row].video?.name
                cell.artistNameLabel.text = uploads[indexPath.row].video?.email
//                cell.musicImageView.imageView?.image = videoController.generateThumbnail(path: uploads[indexPath.row].video!.fileURL)
            }
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
        }
        if(indexPath.section == ExplorerSection.DiscoverNew.rawValue)
        {
        }
        if(indexPath.section == ExplorerSection.LatestMusic.rawValue)
        {
            selectedRow = indexPath.row
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
        }
    }

    
}
