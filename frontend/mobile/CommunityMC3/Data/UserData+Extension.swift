//
//  UserData+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

struct UserDataStruct
{
    // normal data
    var followerCount:Int64
    var genre:String
    var instagram:String
    var isVerified:Bool = false // saved as Int(64)
    var name:String
    var phoneNumber:String
    var role:String
    var whatsApp:String
    
    // asset
    var profilePicture:UIImage?
    
    // ref
    var albums:AlbumDataStruct?
    var favourites:FavouritesDataStruct?
    var musics:TrackDataStruct?
    var photos:PhotoDataStruct?
    var videos:VideosDataStruct?
    
    
    func asDict()->[String:Any]
    {
        return [
            "followerCount":followerCount,
            "genre":genre,
            "instagram":instagram,
            "isVerified":Int(truncating: NSNumber(value: isVerified)),
            "name": name,
            "phoneNumber":phoneNumber,
            "role":role,
            "whatsApp":whatsApp
            ]
    }
}

/*
extension UserData
{
        
    
    static func createPhoto(photoData:PhotoData) -> Photos?
    {
        if let photo:Photos = CoreDataHelper.save(value: photoData.asDict())
        {
            photo.userData = photoData.userData
            return photo
        }
        
        return nil
    }
}
 */
