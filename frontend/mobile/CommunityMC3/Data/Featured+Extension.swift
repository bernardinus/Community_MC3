//
//  Featured+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation


// specific ID
public var FeaturedID_Artist = "featuredArtist"

struct FeaturedDataStruct
{
    var id:String
    var track:[TrackDataStruct]?
    var user:[UserDataStruct]?
    var videos:[VideosDataStruct]?
}

/*
extension Featured
{
    private static var entityName:String = "Featured"
    
    
    static func fetchFeaturedWith(id:String)->[Featured]
    {
        let predicate:NSPredicate = NSPredicate(format: "id == '\(id)'")
        print(predicate)
        let featuredArtist:[Featured] = CoreDataHelper.fetchQuery(entityName,predicate: predicate)
        
        return featuredArtist
    }
}
*/

