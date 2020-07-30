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
    
    var registerData:AccountDataStruct?
    
    func IsUserLogin()->Bool
    {
        return currentUser != nil
    }
    
    private init()
    {
        print("dataManager.init")
        
        ckUtil.setup(cloudKitContainerID: iCloudContainerID)
        
        loginToCloudKit(email: "test4@test4.com", password: "test4")
        
        getLatestUpload()
    }
    
    func registerToCloudKit(email:String,
                            password:String,
                            userData:UserDataStruct,
                            completionHandler:@escaping(Bool, String, CKRecord?)->Void)
    {
        let accRecord:CKRecord = CKRecord(recordType: "Account")
        accRecord.setValue(email, forKey: "email")
        accRecord.setValue(password, forKey: "password")
        
        ckUtil.saveRecordToPublicDB(record: userData.getCKRecord()) {
            (isSuccess, errorString, record) in
            
            if isSuccess
            {
                let userDataRef = CKRecord.Reference(record: record!, action: .deleteSelf)
                accRecord.setValue(userDataRef, forKey: "userData")
                self.ckUtil.saveRecordToPublicDB(record: accRecord) {
                    (isSuccess, errorString, record) in
                    
                    if isSuccess
                    {
                        print("Register User Data Success")
                    }
                    else
                    {
                        print("Register User Data - Account Failed error:\(errorString)")
                    }
                    completionHandler(isSuccess, errorString, record)
                }
            }
            else
            {
                completionHandler(isSuccess,
                                  "Register User Data Failed error:\(errorString)",
                                  nil)
            }
        }
    }
    
    func loginToCloudKit(email:String, password:String)
    {
        let predicate = NSPredicate(format: "email == '\(email)' AND password == '\(password)'")
        let query = CKQuery(recordType: "Account", predicate: predicate)
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, record) in
            if(!isSuccess)
            {
                print("Login to CloudKit Error")
            }
            else
            {
                print("Login to CloudKit Success \(record.count)")
                self.currentUser = record[0]
//                let refUserData = self.currentUser!["userData"] as! CKRecord.Reference
                print("Account: \(self.currentUser!)")
                let userDataRef = self.currentUser!.value(forKey: "userData")! as! CKRecord.Reference
                self.ckUtil.loadRecordFromPublicDB(recordID: userDataRef.recordID) { (isSuccess, errorString, userRecord)  in
                    if(isSuccess)
                    {
                        print("UserData: \(userRecord!)")
                        self.currentUser = userRecord
                        
                        let tracks = userRecord?.value(forKey: "tracks") as! [CKRecord.Reference]
                        let recordNames = tracks.map { $0.recordID.recordName }
                            
                        print("track key :\(tracks))")
                        print("recordID key :\(recordNames))")
                        
                        self.ckUtil.loadRecordFromPublicDB(recordType: "Track", recordName: tracks) { (isSucess, errorString, trackRecords:[CKRecord]) in
                            
                            if(isSuccess)
                            {
                                print("trackRecordsStart:\n \(trackRecords.count) \n trackRecordfinish")
//                                let file = trackRecords[0].value(forKey: "fileURL") as! CKAsset
                            }
                            else
                            {
                                print("failedGet Track: \(errorString)")
                            }
                            
                        }
                    }
                    else
                    {
                        print("Record ID Not Found \(errorString)")
                    }
                }
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
                
                if(self.currentUser != nil)
                {
                    var allTracks = self.currentUser?.value(forKey: "tracks")
                    let ref = CKRecord.Reference(record: record!, action: .deleteSelf)
                    var arr:NSMutableArray? = nil

                    if(allTracks != nil)
                    {
                        print("allTracks not nil")
                        arr = NSMutableArray(array:self.currentUser!["tracks"] as! [CKRecord.Reference])
                        arr!.add(ref)
                        print(arr)
                    }
                    else
                    {
                        print("allTracks nil")
                        arr = NSMutableArray(array: [ref])
                    }
                    self.currentUser?.setValue(arr, forKey: "tracks")

    
    
    
                }
                    
                self.saveCurrentUser()
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
    
    func getLatestUpload()
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
