//
//  MusicSearchCell.swift
//  CommunityMC3
//
//  Created by Theofani on 29/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MusicSearchCell: UITableViewCell {

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var trackData:TrackDataStruct? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(_ trackData:TrackDataStruct)
    {
        self.trackData = trackData
        trackImageView.image = trackData.coverImage
        trackTitleLabel.text = trackData.name
        artistNameLabel.text = trackData.artistName!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
