//
//  Favourites+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

struct FavouritesData
{
    var id:Int = 0
    var album:[Album]
    var track:[Track]
    var userData:UserData?
    var videos:[Videos]
    
    
    init(id:Int,
         album:[Album] = [],
         track:[Track] = [],
         userData:UserData? = nil,
         videos:[Videos] = []
         )
    {
        self.id = id
        self.album = album
        self.track = track
        self.userData = userData
        self.videos = videos
    }
    
    func asDict()->[String:Any]
    {
        return [
            "id":id
            ]
    }
}

extension Favourites
{
        
    
    static func createFavourites(favouritesData:FavouritesData) -> Favourites?
    {
        if let favourite:Favourites = CoreDataHelper.save(value: favouritesData.asDict())
        {
            favourite.album = Set(favouritesData.album.map({$0})) as NSSet
            favourite.track = Set(favouritesData.track.map({$0})) as NSSet
            favourite.userData = favouritesData.userData
            favourite.videos = Set(favouritesData.videos.map({$0})) as NSSet
            return favourite
        }
        
        return nil
    }
}
