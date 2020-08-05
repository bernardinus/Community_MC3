//
//  CloudKitUtil.swift
//  CommunityMC3
//
//  Created by Bernardinus on 29/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitUtil
{
    private static var instance:CloudKitUtil!
    static func shared() -> CloudKitUtil
    {
        if instance == nil
        {
            instance = CloudKitUtil()
        }
        return instance
    }
    
    var container:CKContainer?
    var publicDB:CKDatabase?
    
    
    
    private init()
    {
        
    }
    
    func setup(cloudKitContainerID:String)
    {
        container = CKContainer(identifier: cloudKitContainerID)
        publicDB = container?.publicCloudDatabase
    }
    
    func saveRecordToPublicDB(record:CKRecord,completionHandler:@escaping (Bool, String, CKRecord?)->Void)
    {
        publicDB?.save(record, completionHandler: { (record, error) in
            if let error = error
            {
                completionHandler(false, error.localizedDescription, nil)
            }
            else
            {
                completionHandler(true, "Success", record)
            }
        })
    }
    
    func loadRecordFromPublicDB(query:CKQuery, completionHandler:@escaping(Bool, String, [CKRecord])->Void)
    {
        publicDB?.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
            if error != nil
            {
                completionHandler(false, error!.localizedDescription, [])
            }
            else
            {
                completionHandler(true, "Success", records!)
            }
        })
    }
    
    func loadRecordFromPublicDB(recordID:CKRecord.ID, completionHandler:@escaping(Bool, String, CKRecord?)->Void)
    {
        publicDB?.fetch(withRecordID: recordID, completionHandler: { (record, error) in
            if error != nil
            {
                completionHandler(false, error!.localizedDescription,nil)
            }
            else
            {
                completionHandler(true, "", record)
            }
        })
    }
    
    func loadRecordFromPublicDB(recordType:String,recordName:[CKRecord.Reference], completionHandler:@escaping(Bool, String, [CKRecord])->Void)
    {
        let predicate = NSPredicate(format: "recordID IN %@", recordName)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        publicDB?.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
            if error != nil
            {
                completionHandler(false, error!.localizedDescription, [])
            }
            else
            {
                completionHandler(true, "Success", records!)
            }
        })
    }
    
}
