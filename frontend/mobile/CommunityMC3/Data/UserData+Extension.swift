//
//  UserData+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class UserDataStruct
{
    // normal data
    var followerCount:Int? = 0
    var genre:String? = ""
    var instagram:String? = ""
    var isVerified:Bool = false // saved as Int(64)
    var name:String? = ""
    var phoneNumber:String? = ""
    var role:String? = ""
    var whatsApp:String? = ""
    
    var fileURL:URL? = nil
    var email: String? = ""
    
    var isArtist = false
    
    // asset
    var profilePicture:UIImage? = nil
    
    // ref
    var albums:AlbumDataStruct? = nil
    var favourites:FavouritesDataStruct? = nil
    var musics:[TrackDataStruct]? = []
    var photos:[PhotoDataStruct]? = []
    var videos:[VideosDataStruct]? = []
    var recordID:CKRecord.ID? = nil
    
    init(){}
    init(genre:String, name:String, fileURL:URL, email:String){
        self.genre = genre
        self.name = name
        self.fileURL = fileURL
        self.email = email
    }
    
    init(_ record:CKRecord)
    {
        self.name = record.value(forKey: "name") as? String
        self.genre = record.value(forKey: "genre") as? String
        self.followerCount = record.value(forKey: "followerCount") as? Int
        
        let isVerifiedData = record.value(forKey: "isVerified")
        var isVerifiedIntValue:Int = 0
        if(isVerifiedData != nil )
        {
            isVerifiedIntValue = isVerifiedData as! Int
        }
        
        if(isVerifiedIntValue == 1)
        {
            self.isVerified = true
        }
        
        
        let isArtistData = record.value(forKey: "isArtist")
        var isArtistIntValue:Int = 0
        if(isArtistData != nil )
        {
            isArtistIntValue = isArtistData as! Int
        }
        if(isArtistIntValue == 1)
        {
            self.isArtist = true
        }
        
        self.phoneNumber = record.value(forKey: "phoneNumber") as? String
        self.role = record.value(forKey: "role") as? String
        self.instagram = record.value(forKey: "instagram") as? String
        self.whatsApp = record.value(forKey: "whatsapp") as? String
//        self.profilePicture = UIImage(data: record.value(forKey: "profilePicture") as! Data)
        
        let profPicData = record.value(forKey: "profilePicture")
        if(isArtistData != nil )
        {
            self.profilePicture = UIImage(data: record.value(forKey: "profilePicture") as! Data)
        }
        else
        {
            self.profilePicture = UIImage(color: .magenta)
        }
        
        self.email = record.value(forKey: "email") as? String
    }
    
  
    /*
    func UserDataStruct(record:CKRecord)
    {
        followerCount = record.value(forKey: "followerCount") as? Int
        genre = record.value(forKey: "followerCount") as? String
        instagram = record.value(forKey: "instagram") as? String
        let boolValue = record.value(forKey: "isVerified") as? Int
        isVerified = (boolValue == 1) ? true : false
        name = record.value(forKey: "name") as? String
        phoneNumber = record.value(forKey: "phoneNumber") as? String
        role = record.value(forKey: "role") as? String
        whatsApp = record.value(forKey: "whatsApp") as? String
        profilePicture = UIImage(data: (record.value(forKey: "profilePicture") as? Data)!)
    }
 */
    
    func asDict()->[String:Any]
    {
        return [
            "name": name!,
            "genre":genre!,
            "followerCount":followerCount!,
            "isVerified":Int(truncating: NSNumber(value: isVerified)),
            "phoneNumber":phoneNumber!,
            "role":role!,
            "instagram":instagram!,
            "whatsApp":"",
            "profilePicture":profilePicture!.pngData()!,
            "email":email
        ]
    }
    
    func getCKRecord() -> CKRecord
    {
        let record = CKRecord(recordType: "UserData")
        record.setValuesForKeys(asDict())
        return record
    }
    
}
