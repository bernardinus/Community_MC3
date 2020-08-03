//
//  Photos+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

class PhotoDataStruct
{
    //    var fileData:UIImage?
    
    var fileURL: URL?
    var email: String
    var genre:String
    var name: String
    
    
    init()
    {
        fileURL = URL(string: "")
        email = ""
        genre = ""
        name = ""
    }
}

struct ProfilePictureDataStruct {
    var fileURL: URL
    var email: String
}
