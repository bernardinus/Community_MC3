//
//  Track+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import AVFoundation
import CloudKit

struct PrimitiveTrackDataStruct: Codable
{
    var genre:String
    var name:String
    
    var email: String
}

class TrackDataStruct
{
    
    var genre:String
    var name:String
    
//    var recordID: CKRecord.ID
    var email: String
    var fileData: CKAsset?
//    var coverImage:URL
    
    var audioData:AVAudioPlayer?
    
    
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
    init(genre:String, name:String, email:String, fileURL:URL)
    {
        self.genre = genre
        self.name = name
        self.email = email
        self.fileData = CKAsset(fileURL:fileURL)
    }
    
    func getCKRecord()->CKRecord
    {
        var record = CKRecord(recordType: "Track")
        record.setValue(nil, forKey: "album")
        record.setValue(genre, forKey: "genre")
        record.setValue(email, forKey: "email")
        record.setValue(name, forKey: "name")
        record.setValue(fileData, forKey: "fileData")
        
        return record
    }
}

//class TrackDataClass: NSObject
//{
//    var genre:String!
//    var name:String!
//
//    var recordID: CKRecord.ID!
//    var email: String!
//
//    var audioData:AVAudioPlayer?
//
//    var album:Album?
//}
