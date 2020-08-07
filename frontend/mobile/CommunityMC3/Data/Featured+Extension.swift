//
//  Featured+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CloudKit


// specific ID
public var FeaturedID_Artist = "featuredArtist"

class FeaturedDataStruct
{
    //    var id:String
    var id: CKRecord.ID?
    
    var track: TrackDataStruct?
    var user: UserDataStruct?
    var video: VideosDataStruct?
    
    var tracks:[TrackDataStruct] = []
    var users:[UserDataStruct] = []
    var videos:[VideosDataStruct] = []
    
    init()
    {
    }
    init(id:CKRecord.ID, user:UserDataStruct)
    {
        self.id = id
        self.user = user
    }
    
    init(id:CKRecord.ID, track:TrackDataStruct)
    {
        self.id = id
        self.track = track
    }
    
    init(id:CKRecord.ID, video:VideosDataStruct)
    {
        self.id = id
        self.video = video
    }
}
