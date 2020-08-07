//
//  ArtistSearchCell.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ArtistSearchCell: UITableViewCell {

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistRoleLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    var artistData:UserDataStruct? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        artistImageView.makeRounded()
    }
    
    func updateData(_ artistData:UserDataStruct)
    {
        self.artistData = artistData
        artistImageView.image = artistData.profilePicture!
        artistRoleLabel.text = artistData.role
        artistNameLabel.text = artistData.name!
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {

    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
