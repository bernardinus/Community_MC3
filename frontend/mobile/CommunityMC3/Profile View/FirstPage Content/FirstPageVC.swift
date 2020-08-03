//
//  FirstPageVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum AboutSection:Int{
    case MusicGenre = 0
    case ContactInfo = 1
    case SocialMedia = 2
    case Count = 3
}

class FirstPageVC: UIViewController {
    
    @IBOutlet weak var aboutTableView: UITableView!

    var genreLabel:String!
    var phoneNumberLabel:String!
    var socialMediaLabel:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutTableView.register(UINib(nibName: "AboutHeaderCell", bundle: nil), forCellReuseIdentifier: "aboutHeaderCell")
        aboutTableView.register(UINib(nibName: "MusicGenreInfoCell", bundle: nil), forCellReuseIdentifier: "musicGenreInfoCell")
        aboutTableView.register(UINib(nibName: "ContactInfoCell", bundle: nil), forCellReuseIdentifier: "contactInfoCell")
        aboutTableView.register(UINib(nibName: "SocialMediaCell", bundle: nil), forCellReuseIdentifier: "socialMediaCell")
        aboutTableView.isUserInteractionEnabled = false
        
    }
    
    func updateData(genre:String,
                    phoneNumber:String,
                    socialMedia:String)
    {
        self.genreLabel = genre
        self.phoneNumberLabel = phoneNumber
        self.socialMediaLabel = socialMedia
    }
}

extension FirstPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = aboutTableView.dequeueReusableCell(withIdentifier: "aboutHeaderCell") as! AboutHeaderCell
        if(section == AboutSection.MusicGenre.rawValue)
        {
            cell.aboutHeaderLabel.text = NSLocalizedString("Genre Preferences".uppercased(), comment: "")
        }
        if(section == AboutSection.ContactInfo.rawValue)
        {
            cell.aboutHeaderLabel.text = NSLocalizedString("Contact Info".uppercased(), comment: "")
        }
        if(section == AboutSection.SocialMedia.rawValue)
        {
            cell.aboutHeaderLabel.text = NSLocalizedString("Social Media".uppercased(), comment: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AboutSection.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == AboutSection.MusicGenre.rawValue)
        {
            let cell = aboutTableView.dequeueReusableCell(withIdentifier: "musicGenreInfoCell") as! MusicGenreInfoCell
            cell.genreLabel.text = genreLabel
            return cell
        }
        if(indexPath.section == AboutSection.ContactInfo.rawValue)
        {
            let cell = aboutTableView.dequeueReusableCell(withIdentifier: "contactInfoCell") as! ContactInfoCell
            cell.phoneNumberLabel.text = phoneNumberLabel
            return cell
        }
        if(indexPath.section == AboutSection.SocialMedia.rawValue)
        {
            let cell = aboutTableView.dequeueReusableCell(withIdentifier: "socialMediaCell") as! SocialMediaCell
            cell.socialAccountLabel.text = socialMediaLabel
            return cell
        }
        
        return aboutTableView.dequeueReusableCell(withIdentifier: "musicGenreInfoCell")!
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
