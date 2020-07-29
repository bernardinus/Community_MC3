//
//  UploadedData+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CloudKit

struct UploadedDataStruct
{
    // param
    var uploadedDate:Date?
    
    // ref
//    var track:TrackDataStruct?
//    var video:VideosDataStruct?
    var track:CKRecord?
    var video:CKRecord?
    
    func getCKRecord() -> CKRecord
    {
        let record = CKRecord(recordType: "UploadedData")
        
        record.setValue(uploadedDate, forKey: "uploadedDate")
        
        if track != nil
        {
            let trackRef = CKRecord.Reference(record: track!, action: .deleteSelf)
            record.setValue(trackRef, forKey: "track")
        }
        else
        {
            record.setNilValueForKey("track")
        }
        
        if video != nil
        {
            let trackRef = CKRecord.Reference(record: video!, action: .deleteSelf)
            record.setValue(trackRef, forKey: "video")
        }
        else
        {
            record.setNilValueForKey("video")
        }
            
        return record
    }
}
