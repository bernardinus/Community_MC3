//
//  VideoListCell.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 24/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class VideoListCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var videoThumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
