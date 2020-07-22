//
//  TrendingNowCell.swift
//  CommunityMC3
//
//  Created by Bernardinus on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class TrendingNowCell: UITableViewCell {

    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var favoriteIconButton: UIButton!
    @IBOutlet weak var trackTimerLabel: UILabel!
    @IBOutlet weak var playMusicButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
