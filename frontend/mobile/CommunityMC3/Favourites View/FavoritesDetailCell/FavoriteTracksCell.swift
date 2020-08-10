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
    
    var trackData:TrackDataStruct? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteButton.isSelected = true
        setupButtonImage()
    }
    
    func setupButtonImage()
    {
        playButton.setImage(#imageLiteral(resourceName: "playButtonFavorites"), for: .normal)
        playButton.setImage(#imageLiteral(resourceName: "StopButtonFavorite"), for: .selected)

        favoriteButton.setImage(#imageLiteral(resourceName: "HeartUnfill"), for: .normal)
        favoriteButton.setImage(#imageLiteral(resourceName: "HeartFill"), for: .selected)
    }
    
    func updateData(td:TrackDataStruct)
    {
        trackData = td
        trackCoverImage.image = trackData?.coverImage
        trackTitleLabel.text = trackData?.name
        artistLabel.text = trackData?.artistName
        trackDurationLabel.text = trackData?.duration

        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
