//
//  UploadedData+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

struct UploadedDataStruct
{
    // param
    var uploadedDate:Date
        
    // ref
    var track:TrackDataStruct?
    var video:VideosDataStruct?
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
