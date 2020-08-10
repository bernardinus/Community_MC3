//
//  FavoriteVideosCell.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FavoriteVideosCell: UITableViewCell {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var videoThumbnailImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var videoData:VideosDataStruct? = nil
    
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

        videoThumbnailImage.layer.borderWidth = 0
    }
    
    func updateData(vd:VideosDataStruct)
    {
        videoData = vd
        videoThumbnailImage.image = videoData?.coverImage
        videoThumbnailImage.layer.borderWidth = 2
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
