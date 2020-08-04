//
//  DataManager.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

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
    
    // FEATURED DATA
    var trendingNow:FeaturedDataStruct?
    var newTrendingNow:FeaturedDataStruct?
    
    var latestUpload:[UploadedDataStruct]? = []
    var newLatestUpload:[UploadedDataStruct]? = []
    
    var featuredArtist:FeaturedDataStruct?
    var newFeaturedArtist:FeaturedDataStruct?
    
    var featuredVideos:FeaturedDataStruct?
    var newFeaturedVideos:FeaturedDataStruct?
    
    var allTracks:[TrackDataStruct] = []
    var allVideos:[VideosDataStruct] = []
    var allArtist:[UserDataStruct] = []
    
    var currentUser:UserDataStruct? = nil
    
    // CloudKit Data
    var currentUserRec:CKRecord? = nil
    
    var userTrackRecord:[CKRecord] = []
    var latestUploadRecord:[CKRecord] = []
    var latestFavourite:[CKRecord] = []
    
    var allTracksRec:[CKRecord] = []
    var allVideosRec:[CKRecord] = []
    var allArtistRec:[CKRecord] = []
    
    var registerData:AccountDataStruct?
    
    var userDefault:UserDefaults = UserDefaults.standard
    
    func IsUserLogin()->Bool
    {
        return currentUserRec != nil
    }
    
    private init()
    {
        print("dataManager.init")
        
        ckUtil.setup(cloudKitContainerID: iCloudContainerID)
        
        getFeaturedData()
        autoLoginLastAccount()
        
        getAllMusic()
        getAllVideos()
        getAllArtist()
        
    }
    
    func autoLoginLastAccount()
    {
        let loginEmail:String? = userDefault.string(forKey: "email")
        let loginPassword:String? = userDefault.string(forKey: "password")
        var isSuccessLogin = false
        if(loginEmail != nil && loginPassword != nil)
        {
            if(loginEmail != "" && loginPassword != "")
            {
                isSuccessLogin = true
                print("auto login acc email:\(loginEmail) pass:\(loginPassword)")
                loginToCloudKit(email: loginEmail!,password: loginPassword!, completionHandler: loginSuccess)
            }
        }
        
        if(!isSuccessLogin)
        {
            print("didn't login e:\(loginEmail) p:\(loginPassword)")
        }
    }
    
    func loginSuccess(isSuccess:Bool, errorString:String)
    {
//        print("Auto loginSuccess")
        GetLatestFavourite()
//        updateFeaturedArtist() // to test add user only
    }
    
    
    func logout()
    {
        currentUserRec = nil
        userDefault.set("", forKey: "email")
        userDefault.set("", forKey: "password")
        userDefault.synchronize()
    }
    
    // #MARK: REGISTER
    func registerCurrentLoginInUserDefault(email:String, password:String)
    {
        userDefault.set(email, forKey: "email")
        userDefault.set(password, forKey: "password")
        userDefault.synchronize()
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
                        self.currentUserRec = userData.getCKRecord()
                        self.currentUser = UserDataStruct(self.currentUserRec!)
                        self.registerCurrentLoginInUserDefault(email: email, password: password)
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
    
    // MARK: LOGIN
    func loginToCloudKit(email:String, password:String, completionHandler:@escaping(Bool, String)->Void)
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
//                print("Login to CloudKit Success \(record.count)")
                self.currentUserRec = record[0]
                self.currentUser = UserDataStruct(self.currentUserRec!)
                let userDataRef = self.currentUserRec!.value(forKey: "userData")! as! CKRecord.Reference

                
                self.ckUtil.loadRecordFromPublicDB(recordID: userDataRef.recordID)
                {
                    (isSuccess, errorString, userRecord)  in
                    if(isSuccess)
                    {
//                        print("UserData: \(userRecord!)")
                        self.currentUserRec = userRecord
                        self.currentUser = UserDataStruct(self.currentUserRec!)
                        
                        self.registerCurrentLoginInUserDefault(email: email, password: password)
                        self.loginSuccess(isSuccess: isSuccess, errorString: errorString)
//                        print("Account: \(self.currentUserRec!)")
//
                        
                        let tracksData = userRecord?.value(forKey: "tracks")
                        if(tracksData != nil )
                        {
                            self.loadTracks(tracksData: tracksData)
                        }
                        
                        let videosData = userRecord?.value(forKey: "videos")
                        if(videosData != nil )
                        {
                            self.loadVideos(videosData: videosData)
                        }
                        
                        let photosData = userRecord?.value(forKey: "tracks")
                        if(photosData != nil )
                        {
                            self.loadPhotos(photosData: photosData)
                        }
                    }
                    else
                    {
                        print("Record ID Not Found \(errorString)")
                    }
                    completionHandler(isSuccess, errorString)

                }
                
                
            }
        }
    }
    
    func loadTracks(tracksData:Any?)
    {
        let tracks = tracksData as! [CKRecord.Reference]
        if tracks.count == 0 {return}
        self.ckUtil.loadRecordFromPublicDB(recordType: "Track", recordName: tracks)
        {   (isSuccess, errorString, trackRecords:[CKRecord]) in

            if(isSuccess)
            {
                self.currentUser?.musics?.removeAll()
                for tr in trackRecords
                {
                    self.currentUser?.musics?.append(TrackDataStruct(record: tr))
                }
            }
            else
            {
                print("failedGet Track: \(errorString)")
            }
        }

    }
    
    func loadVideos(videosData:Any?)
    {
        let videos = videosData as! [CKRecord.Reference]
        if videos.count == 0 {return}
        self.ckUtil.loadRecordFromPublicDB(recordType: "Track", recordName: videos)
        {   (isSuccess, errorString, trackRecords:[CKRecord]) in

            if(isSuccess)
            {
                self.currentUser?.videos?.removeAll()
                for tr in trackRecords
                {
                    self.currentUser?.videos?.append(VideosDataStruct(record: tr))
                }
            }
            else
            {
                print("failedGet Track: \(errorString)")
            }
        }

    }
    
    func loadPhotos(photosData:Any?)
    {
        let photos = photosData as! [CKRecord.Reference]
        if photos.count == 0 {return}
        print("photosCount :\(photos.count)")
        
        self.ckUtil.loadRecordFromPublicDB(recordType: "Track", recordName: photos)
        {   (isSuccess, errorString, trackRecords:[CKRecord]) in

            if(isSuccess)
            {
                self.currentUser?.photos?.removeAll()
                for tr in trackRecords
                {
                    self.currentUser?.photos?.append(PhotoDataStruct(record: tr))
                }
            }
            else
            {
                print("failedGet Track: \(errorString)")
            }
        }

    }
    
    // MARK: Update Current User
    func savecurrentUserRec()
    {
        ckUtil.saveRecordToPublicDB(record: currentUserRec!) { (isSuccess, errorString, record) in
            if !isSuccess
            {
                print("Save current user record failed : \(errorString)")
            }
            else
            {
//                print("Save current user record success")
            }
        }
        
    }
    
    
    // MARK: Upload Music
    func UploadNewTrack(trackData:TrackDataStruct, completionHandler:@escaping(Bool, String)->Void)
    {
        ckUtil.saveRecordToPublicDB(
            record: trackData.getCKRecord(),
            completionHandler:{ (isSuccess, errorString, record) in
                if !isSuccess
                {
                    print("UploadNewMusic Error : \(errorString)")
                    completionHandler(isSuccess, errorString)
                }
                else
                {
                    let uploadedData = UploadedDataStruct(uploadedDate: Date.init(timeIntervalSinceNow: 7*3600),
                                                          track: record!,
                                                          video: nil)
                    
                    self.UpdateNewUploadData(record: uploadedData.getCKRecord())
                    
                    if(self.currentUserRec != nil)
                    {
                        var allTracks = self.currentUserRec?.value(forKey: "tracks")
                        let ref = CKRecord.Reference(record: record!, action: .deleteSelf)
                        var arr:NSMutableArray? = nil
                        
                        if(allTracks != nil)
                        {
//                            print("allTracks not nil")
                            arr = NSMutableArray(array:self.currentUserRec!["tracks"] as! [CKRecord.Reference])
                            arr!.add(ref)
                            print(arr)
                        }
                        else
                        {
//                            print("allTracks nil")
                            arr = NSMutableArray(array: [ref])
                        }
                        self.currentUserRec?.setValue(arr, forKey: "tracks")
                        self.currentUserRec?.setValue(1, forKey: "isArtist")
                    }
                    
                    self.savecurrentUserRec()
                    completionHandler(isSuccess, errorString)
                }
                
        })
    }
    
    func UploadNewVideo(videoData:VideosDataStruct, completionHandler:@escaping(Bool, String)->Void)
        {
            ckUtil.saveRecordToPublicDB(
                record: videoData.getCKRecord(),
                completionHandler:{ (isSuccess, errorString, record) in
                    if !isSuccess
                    {
                        print("UploadNewVideo Error : \(errorString)")
                        completionHandler(isSuccess, errorString)
                    }
                    else
                    {
                        let uploadedData = UploadedDataStruct(uploadedDate: Date.init(timeIntervalSinceNow: 7*3600),
                                                              track: nil,
                                                              video: record!)
                        
                        self.UpdateNewUploadData(record: uploadedData.getCKRecord())
                        
                        if(self.currentUserRec != nil)
                        {
                            var allTracks = self.currentUserRec?.value(forKey: "videos")
                            let ref = CKRecord.Reference(record: record!, action: .deleteSelf)
                            var arr:NSMutableArray? = nil
                            
                            if(allTracks != nil)
                            {
    //                            print("allTracks not nil")
                                arr = NSMutableArray(array:self.currentUserRec!["videos"] as! [CKRecord.Reference])
                                arr!.add(ref)
                                print(arr)
                            }
                            else
                            {
    //                            print("allTracks nil")
                                arr = NSMutableArray(array: [ref])
                            }
                            self.currentUserRec?.setValue(arr, forKey: "videos")
                            self.currentUserRec?.setValue(1, forKey: "isArtist")
                        }
                        
                        self.savecurrentUserRec()
                        completionHandler(isSuccess, errorString)
                    }
                    
            })
        }
    
    func UploadNewPhoto(photoData:PhotoDataStruct, completionHandler:@escaping(Bool, String)->Void)
        {
            ckUtil.saveRecordToPublicDB(
                record: photoData.getCKRecord(),
                completionHandler:{ (isSuccess, errorString, record) in
                    if !isSuccess
                    {
                        print("UploadNewPhotos Error : \(errorString)")
                        completionHandler(isSuccess, errorString)
                    }
                    else
                    {
//                        let uploadedData = UploadedDataStruct(uploadedDate: Date.init(timeIntervalSinceNow: 7*3600),
//                                                              track: record!,
//                                                              video: nil)
//
//                        self.UpdateNewUploadData(record: uploadedData.getCKRecord())
                        
                        if(self.currentUserRec != nil)
                        {
                            var allTracks = self.currentUserRec?.value(forKey: "photos")
                            let ref = CKRecord.Reference(record: record!, action: .deleteSelf)
                            var arr:NSMutableArray? = nil
                            
                            if(allTracks != nil)
                            {
    //                            print("allTracks not nil")
                                arr = NSMutableArray(array:self.currentUserRec!["photos"] as! [CKRecord.Reference])
                                arr!.add(ref)
                                print(arr)
                            }
                            else
                            {
    //                            print("allTracks nil")
                                arr = NSMutableArray(array: [ref])
                            }
                            self.currentUserRec?.setValue(arr, forKey: "photos")
                            self.currentUserRec?.setValue(1, forKey: "isArtist")
                        }
                        
                        self.savecurrentUserRec()
                        completionHandler(isSuccess, errorString)
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
//                print("Upload New Data Success :\(errorString)")
            }
        }
    }
    
    // MARK: FEATURED
    func getFeaturedData()
    {
//        getTrendingNow()
        getLatestUpload()
        getFeaturedArtist()
//        getFeaturedVideo()
    }
    
    //MARK: TRENDING NOW
    func getTrendingNow()
    {
        let query = CKQuery(recordType: "Featured", predicate: NSPredicate(format: "id = %@", "trendingNow"))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("GetFeaturedID Error")
            }
            else
            {
//                print("GetFeaturedID Success")
                let count:Int = records.count
                if count > 0
                {
                    
                    let trendingNowRecord = records[0]
                    self.newTrendingNow  = FeaturedDataStruct()
                    self.newTrendingNow!.id = trendingNowRecord.recordID
                    
                    let trackRefArr = trendingNowRecord.value(forKey: "tracks") as! [CKRecord.Reference]
                    self.ckUtil.loadRecordFromPublicDB(recordType: "Tracks", recordName: trackRefArr, completionHandler: self.trendingNowTracksResult)
                    
                    
                    self.latestUploadRecord = records
                    print(self.latestUploadRecord)
                }
                else
                {
                    print("GetFeaturedArtist Error 0 Count")
                }
            }
        }
    }
    
    func trendingNowTracksResult(isSuccess:Bool, errorString:String, records:[CKRecord])
    {
        if(isSuccess)
        {
            print("Trending now getTracks Success")
            self.newTrendingNow?.tracks.removeAll()
            for record in records
            {
                
            }
        }
        else
        {
            print("Trending now getTracks Failed")
        }
    }
    
    // MARK: LATEST UPLOAD
    func getLatestUpload()
    {
        let query = CKQuery(recordType: "UploadedData", predicate: NSPredicate(value: true))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("GetLatestUpload Error")
            }
            else
            {
                self.latestUploadRecord = records
                let maxRecords = records.count
//                print("GetLatestUpload Success \(records.count)")
                var idx = 0
                for record in records
                {
                    var upData = UploadedDataStruct()
                    var usedRef = record.value(forKey: "video") as? CKRecord.Reference
                    if usedRef == nil
                    {
                        upData.isVideo = false
                        usedRef = record.value(forKey: "track") as? CKRecord.Reference
                    }
                    let cIDX = idx
                    self.ckUtil.loadRecordFromPublicDB(recordID: usedRef!.recordID) { (dataIsSuccess, dataErrorStr, dataRecord) in
                        self.updateUploadedDataStuct(uploadedData: upData, idx: cIDX, isSuccess: dataIsSuccess, errorString: dataErrorStr, record: dataRecord!, maxRecords: maxRecords)
                    }
                    idx += 1
                }
                
                
                print(self.latestUploadRecord)
            }
        }
    }
    
    func updateExplorerView()
    {
        DispatchQueue.main.async {
            
            let rootView = UIApplication.shared.keyWindow?.rootViewController! as! UINavigationController
            let tabBarView = rootView.viewControllers[0] as! UITabBarController
            let explorerView = tabBarView.viewControllers![0] as! ExplorerView
            explorerView.mainTableView.reloadData()
//            print("check arr \(tabBarView.viewControllers![0])")

        }
        
    }
    
    func updateUploadedDataStuct(uploadedData:UploadedDataStruct, idx:Int, isSuccess:Bool, errorString:String, record:CKRecord, maxRecords:Int)
    {
        if(isSuccess)
        {
            uploadedData.updateData(recordMediaData: record)
            self.newLatestUpload!.append(uploadedData)
//            print("Get UploadedDataStruct success: \(idx) \(self.newLatestUpload!.count) \(maxRecords)")
            
            if(self.newLatestUpload!.count == maxRecords)
            {
                self.latestUpload = self.newLatestUpload
                updateExplorerView()
            }
        }
        else
        {
            print("Get UploadedDataStruct Failed: \(errorString)")
        }
    }
    
    // MARK: FEATURED ARTIST
    func getFeaturedArtist()
    {
        let query = CKQuery(recordType: "Featured", predicate: NSPredicate(format: "id = %@", "featuredArtist"))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("GetFeaturedArtist Error")
            }
            else
            {
                let count:Int = records.count
                if count > 0
                {
//                    print("GetFeaturedArtist Success \(records.count)")
                    let featuredArtistRecord = records[0]
                    print(featuredArtistRecord)
                    self.newFeaturedArtist  = FeaturedDataStruct()
                    self.newFeaturedArtist?.id = featuredArtistRecord.recordID
                    
                    let artistRefArrData = featuredArtistRecord.value(forKey: "users")
                    if(artistRefArrData != nil)
                    {
                        let artistRefArr = artistRefArrData as! [CKRecord.Reference]
                        self.ckUtil.loadRecordFromPublicDB(recordType: "UserData", recordName: artistRefArr, completionHandler: self.featuredArtistTrackResult)
                        
                        self.latestUploadRecord = records
                        print(self.latestUploadRecord)
                    }
                }
                else
                {
                    print("GetFeaturedArtist Error 0 Count")
                }
                
            }
        }
    }
    
    func featuredArtistTrackResult(isSuccess:Bool, errorString:String, records:[CKRecord])
    {
        if(isSuccess)
        {
            print("Featured Artist Get User Success \(records.count)")
            self.newFeaturedArtist?.users.removeAll()
            for record in records
            {
                var userData = UserDataStruct(record)
                self.newFeaturedArtist?.users.append(userData)
                
            }
            self.featuredArtist = newFeaturedArtist
            updateExplorerView()
            print("FeaturedArtist :\(self.featuredArtist?.users.count)")
        }
        else
        {
            print("Featured Artist Get User Failed")
        }
    }
    
    func updateFeaturedArtist()
    {
        let query = CKQuery(recordType: "Featured", predicate: NSPredicate(format: "id = %@", "featuredArtist"))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("GetFeaturedArtist Error")
            }
            else
            {
                let count:Int = records.count
                if count > 0
                {
                    print("GetFeaturedArtist Success \(records.count)")
                    let featuredArtistRecord = records[0]
                    print(featuredArtistRecord)
                    self.newFeaturedArtist  = FeaturedDataStruct()
                    self.newFeaturedArtist?.id = featuredArtistRecord.recordID
                    
                    let artistRefArrData = featuredArtistRecord.value(forKey: "users")
                    var arr:NSMutableArray? = nil
                    let ref = CKRecord.Reference(record: self.currentUserRec!, action: .deleteSelf)
                    if(artistRefArrData != nil)
                    {
                        arr = NSMutableArray(array:(artistRefArrData as! [CKRecord.Reference]))
                        arr!.add(ref)
                    }
                    else
                    {
                        arr = NSMutableArray(array: [ref])

                    }
                        
                    featuredArtistRecord.setValue(arr, forKey: "users")
                    self.ckUtil.saveRecordToPublicDB(record: featuredArtistRecord) { (isSuccess, errorString, record) in
                        print("update Record FeaturedArtist: \(isSuccess) \(errorString)")
                    }
                }
                else
                {
                    print("GetFeaturedArtist Error 0 Count")
                }
                
            }
        }
    }
    
    
    
    // MARK: FEATURED VIDEO
    func getFeaturedVideo()
    {
        let query = CKQuery(recordType: "Featured", predicate: NSPredicate(format: "id = %@", "featuredVideo"))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("GetFeaturedVideos Error")
            }
            else
            {
                let count = records.count
                
                
                if(count > 0)
                {
                    print("GetFeaturedVideos Success")
                    let trendingNowRecord = records[0]
                    self.newTrendingNow  = FeaturedDataStruct()
                    self.newTrendingNow!.id = trendingNowRecord.recordID
    
                    let trackRefArr = trendingNowRecord.value(forKey: "tracks") as! [CKRecord.Reference]
                    self.ckUtil.loadRecordFromPublicDB(recordType: "Tracks", recordName: trackRefArr, completionHandler: self.trendingNowTracksResult)
    
    
                    self.latestUploadRecord = records
                    print(self.latestUploadRecord)
                }
                else
                {
                    print("GetFeaturedVideos Error 0 Count")
                }
            }
        }
    }
    
    
    // MARK: FAVOURITE
    
    func UploadNewFavourite(favouriteData:FavouritesDataStruct, completionHandler:(Bool, String)->Void)
    {
        
        ckUtil.saveRecordToPublicDB(
            record: favouriteData.getCKRecord(),
            completionHandler:{ (isSuccess, errorString, record) in
                if !isSuccess
                {
                    print("UploadNewFavourite Error : \(errorString)")
                }
                else
                {
                    print("UploadNewFavourite Success")
                }
        })
        
    }
    
    func GetLatestFavourite()
    {
        let query = CKQuery(recordType: "Favourites", predicate: NSPredicate(value: true))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, record) in
            if(!isSuccess)
            {
                print("GetLatestFavourite Error")
            }
            else
            {
                print("GetLatestFavourite Success")
                self.latestFavourite = record
                print(self.latestFavourite)
            }
        }
    }
    
    // MARK: GET ALL
    func getAllMusic()
    {
        let query = CKQuery(recordType: "Track", predicate: NSPredicate(value: true))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("getAllMusic Error")
            }
            else
            {
                print("getAllMusic Success")
                self.allTracksRec = records
                self.allTracks.removeAll()
                for record in records
                {
                    self.allTracks.append(TrackDataStruct(record:record))
                }
            }
        }
    }
    
    func getAllVideos()
    {
        let query = CKQuery(recordType: "Videos", predicate: NSPredicate(value: true))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("getAllVideos Error")
            }
            else
            {
                print("getAllVideos Success")
                self.allVideosRec = records
                self.allVideos.removeAll()
                for record in records
                {
                    self.allVideos.append(VideosDataStruct(record: record))
                }
            }
        }
    }
    
    func getAllArtist()
    {
        let query = CKQuery(recordType: "UserData", predicate: NSPredicate(format: "isArtist = 1"))
        ckUtil.loadRecordFromPublicDB(query: query) { (isSuccess, errorString, records) in
            if(!isSuccess)
            {
                print("getAllArtist Error")
            }
            else
            {
                print("getAllArtist Success")
                self.allArtistRec = records
                self.allArtist.removeAll()
                for record in records
                {
                    self.allArtist.append(UserDataStruct(record))
                }
            }
        }
    }
}
