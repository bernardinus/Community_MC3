//
//  DataManager.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CloudKit

class DataManager
{
    private static var instance:DataManager!
    static func shared() -> DataManager
    {
        if instance == nil
        {
            instance = DataManager()
        }
        return instance
    }
    
    var selectedTrackData:TrackDataStruct? = nil
    var selectedVideoData:VideosDataStruct? = nil
    
    var trendingNowList:[TrackDataStruct]? = nil
    var latestList:[UploadedDataStruct]? = nil
    var featuredArtistList:[UserDataStruct]? = nil
    var featuredVideoLis:[VideosDataStruct]? = nil
    
    var ckUtil:CloudKitUtil = CloudKitUtil.shared()
    
    // CloudKit Data
    var currentUser:CKRecord? = nil
    var userTrackRecord:[CKRecord] = []
    var latestUpload:[CKRecord] = []
    
    private init()
    {
        print("dataManager.init")
        print()
        ckUtil.setup(cloudKitContainerID: iCloudContainerID)
        loginToCloudKit()
        GetLatestUpload()
    }
    
    func loginToCloudKit()
    {
        let query = CKQuery(recordType: "Account", predicate: NSPredicate(value: true))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, record) in
            if(!isSuccess)
            {
                print("Login to CloudKit Error")
            }
            else
            {
                print("Login to CloudKit Success")
                self.currentUser = record[0]
                print(self.currentUser)
            }
        }
    }
    
    func saveCurrentUser()
    {
        ckUtil.saveRecordToPublicDB(record: currentUser!) { (isSuccess, errorString, record) in
            if !isSuccess
            {
                print("Save current user record failed : \(errorString)")
            }
            else
            {
                print("Save current user record success")
            }
        }

    }
    
    func UploadNewTrack(trackData:TrackDataStruct, completionHandler:(Bool, String)->Void)
    {
        ckUtil.saveRecordToPublicDB(
            record: trackData.getCKRecord(),
            completionHandler:{ (isSuccess, errorString, record) in
            if !isSuccess
            {
                print("UploadNewMusic Error : \(errorString)")
            }
            else
            {
                let uploadedData = UploadedDataStruct(uploadedDate: Date.init(timeIntervalSinceNow: 7*3600),
                                   track: record,
                                   video: nil)
                
                self.UpdateNewUploadData(record: uploadedData.getCKRecord())
                
//                if(self.currentUser != nil)
//                {
//                    var allTracks = self.currentUser?.value(forKey: "tracks")
//                    if(allTracks != nil)
//                    {
////                        allTracks = self.currentUser!["tracks"] as! [CKRecord.Reference]
//                        print("allTracks not nil")
//                    }
//                    else
//                    {
//                        print("allTracks nil")
//                        var ref = CKRecord.Reference(record: record!, action: .deleteSelf)
//                        self.currentUser?.setValue(ref, forKey: "tracks")
//                    }
//
//
//
//
//                }
                
//                self.saveCurrentUser()
            }
                
        })
    }
    
    
    func UpdateNewUploadData(record:CKRecord)
    {
        ckUtil.saveRecordToPublicDB(record: record) { (isSuccess, errorString, record) in
            if !isSuccess
            {
                print("Upload New Data Error :\(errorString)")
            }
            else
            {
                print("Upload New Data Success :\(errorString)")
            }
        }
    }
    
    func GetLatestUpload()
    {
        let query = CKQuery(recordType: "UploadedData", predicate: NSPredicate(value: true))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, record) in
            if(!isSuccess)
            {
                print("GetLatestUpload Error")
            }
            else
            {
                print("GetLatestUpload Success")
                self.latestUpload = record
                print(self.latestUpload)
            }
        }
    }
}
