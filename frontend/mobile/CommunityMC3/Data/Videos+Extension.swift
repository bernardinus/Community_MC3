//
//  Videos+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import AVKit

struct VideosDataStruct
{
    // normal param
    var genre:String
    var name:String
    
    // asset
    var videoData:AVPlayer?
    
    
    // ref
    var album:Album?
}

/*
extension Photos
{
        
    
    static func createPhoto(photoData:PhotoData) -> Photos?
    {
        if let photo:Photos = CoreDataHelper.save(value: photoData.asDict())
        {
            photo.userData = photoData.userData
            return photo
        }
        
        return nil
    }
}
*/
