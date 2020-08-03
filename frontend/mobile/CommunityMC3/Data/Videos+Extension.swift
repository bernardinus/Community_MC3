//
//  Videos+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import AVKit
import CloudKit

class VideosDataStruct
{
    // normal param
    var genre:String
    var name:String
    var email:String
    var fileData:CKAsset? = nil
    
    
    
    // asset
    var videoData:AVPlayer?
    
    
    
    // ref
    var album:AlbumDataStruct?
    
    init(record:CKRecord)
    {
        self.genre = record.value(forKey: "genre") as! String
        self.name = record.value(forKey: "name") as! String
        self.email = record.value(forKey: "email") as! String
        self.fileData = record.value(forKey: "fileData") as? CKAsset
        
    }
    
    init()
    {
        self.genre = ""
        self.name = ""
        self.email = ""
        self.fileData = CKAsset(fileURL: URL(string: "")!)

    }
    init(genre: String, name:String, email:String, fileURL:URL)
    {
        self.genre = genre
        self.name = name
        self.email = email
        self.fileData = CKAsset(fileURL:fileURL)
        
    }
}

struct PrimitiveVideosDataStruct: Codable
{
    // normal param
    var genre:String
    var name:String
    var email:String
}
