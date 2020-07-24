//
//  Favourites+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

struct FavouritesDataStruct
{
    var id:Int = 0
    var album:[AlbumDataStruct]?
    var track:[TrackDataStruct]?
    var user:[UserDataStruct]?
    var videos:[VideosDataStruct]?
    
    
    init(id:Int,
         album:[AlbumDataStruct] = [],
         track:[TrackDataStruct] = [],
         videos:[VideosDataStruct] = [],
         user:[UserDataStruct]?
        )
    {
        self.id = id
        self.album = album
        self.track = track
        self.videos = videos
    }
    
    func asDict()->[String:Any]
    {
        return [
            "id":id
            ]
    }
}

/*
extension Favourites
{
        
    
    static func createFavourites(favouritesData:FavouritesDataStruct) -> Favourites?
    {
        if let favourite:Favourites = CoreDataHelper.save(value: favouritesData.asDict())
        {
            favourite.album = Set(favouritesData.album.map({$0})) as NSSet
            favourite.track = Set(favouritesData.track.map({$0})) as NSSet
            favourite.videos = Set(favouritesData.videos.map({$0})) as NSSet
            return favourite
        }
        
        return nil
    }
}
 */
