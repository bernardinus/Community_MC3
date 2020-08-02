//
//  UploadedData+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CloudKit

class UploadedDataStruct
{
    // param
    var uploadedDate:Date?
    
    // ref
//    var track:TrackDataStruct?
//    var video:VideosDataStruct?
    var trackRecord:CKRecord?
    var videoRecord:CKRecord?
    
    var isVideo:Bool = false
    
    var trackData:TrackDataStruct?
    var videoData:VideosDataStruct?
    
    init(){
        isVideo = false
    }
    /*
    init(record:CKRecord)
    {
        uploadedDate = record.value(forKey: "uploadedDate") as? Date

        let trackRef = record.value(forKey: "track") as? CKRecord.Reference
        if(trackRef != nil)
        {
            CloudKitUtil.shared().loadRecordFromPublicDB(recordID: trackRef!.recordID, completionHandler: {
                (isSuccess, errorString, record) in
                if(isSuccess)
                {
                    self.trackRecord = record
                }
                
            })
        }

        let videoRef = record.value(forKey: "video") as? CKRecord.Reference
        if(videoRef != nil)
        {
            CloudKitUtil.shared().loadRecordFromPublicDB(recordID: videoRef!.recordID, completionHandler: {
                (isSuccess, errorString, record) in
                if(isSuccess)
                {
                    self.videoRecord = record
                }
                
            })
        }

        isVideo = self.videoRecord != nil
    }
 */
    
    init(uploadedDate:Date, track:CKRecord?, video:CKRecord?)
    {
        self.uploadedDate = uploadedDate
        self.trackRecord = track
        self.videoRecord = video
    }
    
    func updateData(recordMediaData:CKRecord)
    {
//        print("recordData \(recordMediaData)")
        if(isVideo)
        {
            videoData = VideosDataStruct(record: recordMediaData)
        }
        else
        {
            trackData = TrackDataStruct(record: recordMediaData)
        }
    }
    
    func getCKRecord() -> CKRecord
    {
        let record = CKRecord(recordType: "UploadedData")
        
        record.setValue(uploadedDate, forKey: "uploadedDate")
        
        if trackRecord != nil
        {
            let trackRef = CKRecord.Reference(record: trackRecord!, action: .deleteSelf)
            record.setValue(trackRef, forKey: "track")
        }
        else
        {
            record.setNilValueForKey("track")
        }
        
        if videoRecord != nil
        {
            let trackRef = CKRecord.Reference(record: videoRecord!, action: .deleteSelf)
            record.setValue(trackRef, forKey: "video")
        }
        else
        {
            record.setNilValueForKey("video")
        }
            
        return record
    }
}
