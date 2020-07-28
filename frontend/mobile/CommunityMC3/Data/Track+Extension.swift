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
    
    var recordID: CKRecord.ID
    var email: String
    var fileURL: URL
    
    var audioData:AVAudioPlayer?
    
    var album:AlbumDataStruct?
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

/*
 extension Track
 {
 
 
 static func createTrack(trackData:TrackData) -> Track?
 {
 if let track:Track = CoreDataHelper.save(value: trackData.asDict())
 {
 track.user = trackData.user
 return track
 }
 
 return nil
 }
 }
 */
