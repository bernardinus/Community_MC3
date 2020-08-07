//
//  VideoSearchCell.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class VideoSearchCell: UITableViewCell {

    
    @IBOutlet weak var videoThumbnailImage: UIImageView!
    @IBOutlet weak var darkGradientOverlay: UIImageView!
    
    var videoData:VideosDataStruct? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoThumbnailImage.layer.cornerRadius = 10
        darkGradientOverlay.layer.cornerRadius = 10
       
    }
    
    func updateData(_ videoData:VideosDataStruct)
    {
        self.videoData = videoData
        videoThumbnailImage.image = videoData.coverImage
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


