//
//  Photos+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

struct PhotoData
{
    var fileData:Data = Data(base64Encoded: "")!
    var userData:UserData
    
    init(imageFile:UIImage,
         userData:UserData
         )
    {
        self.fileData = imageFile.pngData()!
        self.userData = userData
    }
    
    func asDict()->[String:Any]
    {
        return [
            "fileData":fileData
            ]
    }
}

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
