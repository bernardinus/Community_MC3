//
//  Featured+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation


//struct UserData
//{
//    var user_id:Int16 = 0 // self updating
//    var profilePicture:Data = Data(base64Encoded: "")!
//    var password:String
//    var name:String
//    var email:String
//    var profPicImgName:String
//
//    init(name:String, email:String, profPicImgName:String) {
//        self.name = name
//        self.email = email
//        self.profPicImgName = profPicImgName
//        self.password = name.components(separatedBy: " ").first!
//    }
//
//    func asDict()->[String:Any]
//    {
//        return [
//            "user_id":user_id,
//            "profilePicture":profilePicture,
//            "name": name,
//            "email": email,
//            "password":password
//            ]
//    }
//}

extension Featured
{
    private static var entityName:String = "Featured"
    public static var FeaturedArtistID = "featuredArtist"
    
    static func fetchFeaturedWith(id:String)->[Featured]
    {
        let predicate:NSPredicate = NSPredicate(format: "id == '\(id)'")
        print(predicate)
        let featuredArtist:[Featured] = CoreDataHelper.fetchQuery(entityName,predicate: predicate)
        
        return featuredArtist
    }
}


