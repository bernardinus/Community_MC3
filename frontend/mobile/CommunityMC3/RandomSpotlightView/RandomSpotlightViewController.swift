//
//  RandomSpotlightViewController.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum RandomSearch: Int {
    case Music = 0
    case Video = 1
    case Count = 2
}

class RandomSpotlightViewController: UIViewController{

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var innerCircleEffectImage: UIImageView!
    @IBOutlet weak var outerCircleEffectImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var musicAndVideoTableView: UITableView!
    @IBOutlet weak var popUpContentView: UIView!
    
    var test = false
    var musicGenreArray = ["Rock","Jazz","Pop","RnB","Acoustic","Blues"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
    }
    
    func setupBackground(){
        //set gradient background in view
        let viewBackground = CAGradientLayer()
        viewBackground.colors = [#colorLiteral(red: 0.8862745098, green: 0.03529411765, blue: 0.168627451, alpha: 1).cgColor, #colorLiteral(red: 0.2823529412, green: 0.003921568627, blue: 0.7843137255, alpha: 1).cgColor]
        viewBackground.frame = view.frame
        view.layer.insertSublayer(viewBackground, at: 0)
        view.bringSubviewToFront(contentView)
        
        //set to white color
        titleLabel.textColor = UIColor.white
        statusLabel.textColor = UIColor.white
        editButton.setTitleColor(UIColor.white, for: .normal)
        genreCollectionView.register(UINib(nibName: "MusicGenreCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
        musicAndVideoTableView.register(UINib(nibName: "HeaderCellRandomSpotlight", bundle: nil), forCellReuseIdentifier: "headerCellRandom")
        musicAndVideoTableView.register(UINib(nibName: "MusicListCell", bundle: nil), forCellReuseIdentifier: "musicList")
        musicAndVideoTableView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellReuseIdentifier: "videoList")
        
        popUpContentView.layer.cornerRadius = 12
        popUpContentView.isHidden = true
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 2.0, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                self.outerCircleEffectImage?.transform = CGAffineTransform (scaleX:1.7 , y: 1.7)
            })
        }, completion: {(_ finished: Bool) -> Void in
            self.outerCircleEffectImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        UIView.animate(withDuration: 2.0, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                self.innerCircleEffectImage?.transform = CGAffineTransform (scaleX:1.2 , y: 1.2)
            })
        }, completion: {(_ finished: Bool) -> Void in
            self.innerCircleEffectImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        UIView.animate(withDuration: 2.0, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                self.searchButton?.transform = CGAffineTransform (scaleX:0.9 , y: 0.9)
            })
        }, completion: {(_ finished: Bool) -> Void in
            self.searchButton?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        
        
    }
    @IBAction func editButtonAction(_ sender: UIButton) {
        let editRandomizerVC = storyboard?.instantiateViewController(identifier: "EditRandomizerVC") as! EditRandomizerViewController
        editRandomizerVC.transitioningDelegate = self
        editRandomizerVC.modalPresentationStyle = .custom
        editRandomizerVC.view.layer.cornerRadius = 34
     
        self.present(editRandomizerVC, animated: true, completion: nil)
        
    }
    
}
extension RandomSpotlightViewController : UIViewControllerTransitioningDelegate, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == RandomSearch.Music.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCellRandom") as! HeaderCellRandomSpotlight
            cell.headerTitle.text = "MUSIC"
            return cell
        }else if section == RandomSearch.Video.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCellRandom") as! HeaderCellRandomSpotlight
            cell.headerTitle.text = "VIDEO"
            return cell
        }
        return musicAndVideoTableView.dequeueReusableCell(withIdentifier: "headerCellRandom")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RandomSearch.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == RandomSearch.Music.rawValue {
            return 5
        }else if section == RandomSearch.Video.rawValue{
            return 7
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == RandomSearch.Music.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "musicList", for: indexPath) as! MusicListCell
            return cell
        }else if indexPath.section == RandomSearch.Video.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoList", for: indexPath) as! VideoListCell
            cell.videoThumbnailImage.layer.borderWidth = 2
            return cell
        }
        return musicAndVideoTableView.dequeueReusableCell(withIdentifier: "musicList")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == RandomSearch.Music.rawValue{
            return 60
        }else if indexPath.section == RandomSearch.Video.rawValue{
            return 130
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! MusicGenreCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        cell.musicGenreLabel.text = musicGenreArray[indexPath.row]
        for genre in musicGenreArray{
            switch genre {
            case "Rock":
                cell.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
            case "Pop":
                cell.layer.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            default:
                break
            }
        }
        return cell
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
        }
    }
}

