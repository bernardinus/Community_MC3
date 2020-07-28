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
    var id:String
    var album:[AlbumDataStruct]?
//    var track:[TrackDataStruct]?
    var track:[PrimitiveTrackDataStruct]?
    var user:[UserDataStruct]?
//    var videos:[VideosDataStruct]?
    var videos:[PrimitiveVideosDataStruct]?
    
    
    init(id:String,
         album:[AlbumDataStruct] = [],
//         track:[TrackDataStruct] = [],
        track:[PrimitiveTrackDataStruct] = [],
//         videos:[VideosDataStruct] = [],
        videos:[PrimitiveVideosDataStruct] = [],
         user:[UserDataStruct]? = []
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
