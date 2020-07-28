//
//  MusicListCell.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 24/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MusicListCell: UITableViewCell {
    
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    @IBOutlet weak var trackCurrent: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        playButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
//        playButton.setImage(#imageLiteral(resourceName: "Stop"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
