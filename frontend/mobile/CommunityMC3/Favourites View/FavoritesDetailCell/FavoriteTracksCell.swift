//
//  FavoriteTracksCell.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FavoriteTracksCell: UITableViewCell {

    @IBOutlet weak var trackCoverImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var trackDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteButton.isSelected = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
