//
//  Favourites+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CloudKit

struct FavouritesDataStruct
{
    var id:String
    var album:[AlbumDataStruct]?
    //    var track:[TrackDataStruct]?
    var track:[PrimitiveTrackDataStruct]?
    var trackRef: CKRecord?
    var user:[UserDataStruct]?
    //    var videos:[VideosDataStruct]?
    var videos:[PrimitiveVideosDataStruct]?
    var videoRef: CKRecord?
    
    func getCKRecord() -> CKRecord
    {
        let record = CKRecord(recordType: "Favourites")
        
        record.setValue(id, forKey: "id")
        
        if trackRef != nil
        {
            let trackRef = CKRecord.Reference(record: self.trackRef!, action: .deleteSelf)
            record.setValue(trackRef, forKey: "trackRef")
        }
        else
        {
            record.setNilValueForKey("trackRef")
        }
        
        if videoRef != nil
        {
            let videoRef = CKRecord.Reference(record: self.videoRef!, action: .deleteSelf)
            record.setValue(videoRef, forKey: "videoRef")
        }
        else
        {
            record.setNilValueForKey("videoRef")
        }
            
        return record
    }
    
//    func getDataStruct()->FavouritesDataStruct {
//        let favourite = FavouriteData
//    }
    
    
    init(id:String,
         album:[AlbumDataStruct] = [],
         //         track:[TrackDataStruct] = [],
        track:[PrimitiveTrackDataStruct] = [],
        //         videos:[VideosDataStruct] = [],
        videos:[PrimitiveVideosDataStruct] = [],
        user:[UserDataStruct]? = []
    )
    {
        self.id = id
        self.album = album
        self.track = track
        self.videos = videos
    }
    
    func asDict()->[String:Any]
    {
        return [
            "id":id
        ]
    }
}
