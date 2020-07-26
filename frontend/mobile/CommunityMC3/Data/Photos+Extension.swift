//
//  Photos+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

struct PhotoDataStruct
{
//    var fileData:UIImage?
    
    var fileURL: URL
    var email: String
    var genre:String
    var name: String
}

struct ProfilePictureDataStruct {
    var fileURL: URL
    var email: String
}

/*
extension Photos
{
        
    
    static func createPhoto(photoData:PhotoData) -> Photos?
    {
        if let photo:Photos = CoreDataHelper.save(value: photoData.asDict())
        {
            return photo
        }
        
        return nil
    }
}
 */
