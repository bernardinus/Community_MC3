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

struct TrackDataStruct
{
    
    var genre:String
    var name:String
    
//    var recordID: CKRecord.ID
    var email: String
    var fileURL: URL
//    var coverImage:URL
    
    var audioData:AVAudioPlayer?
    
    
    var album:AlbumDataStruct?
    
    func getCKRecord()->CKRecord
    {
        var record = CKRecord(recordType: "Track")
        record.setValue(nil, forKey: "album")
        record.setValue(genre, forKey: "genre")
        record.setValue(email, forKey: "email")
        record.setValue(name, forKey: "name")
        
        let fileData = CKAsset(fileURL: fileURL)
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
