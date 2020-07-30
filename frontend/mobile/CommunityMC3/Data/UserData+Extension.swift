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

struct UserDataStruct
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
    var email: String = ""
    
    // asset
    var profilePicture:UIImage? = nil
    
    // ref
    var albums:AlbumDataStruct? = nil
    var favourites:FavouritesDataStruct? = nil
    var musics:TrackDataStruct? = nil
    var photos:PhotoDataStruct? = nil
    var videos:VideosDataStruct? = nil
    var recordID:CKRecord.ID? = nil
    
    func UserDataStruct()
    {
        
    }
    
    mutating func UserDataStruct(record:CKRecord)
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
    
    func asDict()->[String:Any]
    {
        return [
            "followerCount":followerCount!,
            "genre":genre!,
            "instagram":instagram!,
            "isVerified":Int(truncating: NSNumber(value: isVerified)),
            "name": name!,
            "phoneNumber":phoneNumber!,
            "role":role!,
            "whatsApp":whatsApp!,
            "profilePicture":profilePicture!.pngData()!
        ]
    }
    
    func getCKRecord() -> CKRecord
    {
        let record = CKRecord(recordType: "UserData")
        record.setValuesForKeys(asDict())
        return record
    }
    
}
