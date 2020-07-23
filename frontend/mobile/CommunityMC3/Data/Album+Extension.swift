//
//  Album.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

struct AlbumData
{
    var cover:Data = Data(base64Encoded: "")!
    var name:String
    
    var favourites:Favourites?
    var tracks:[Track]
    var userData:UserData?
    var videos:[Videos]
    
    
    init(imageFile:UIImage,
         name:String,
         favourites:Favourites? = nil,
         userData:UserData? = nil,
         tracks:[Track] = [],
         videos:[Videos] = []
         )
    {
        self.cover = imageFile.pngData()!
        self.name = name
        self.favourites = favourites
        self.userData = userData
        self.tracks = tracks
        self.videos = videos
    }
    
    func asDict()->[String:Any]
    {
        return [
            "cover":cover,
            "name":name
            ]
    }
}

extension Album
{
        
    
    static func createAlbum(albumData:AlbumData) -> Album?
    {
        if let album:Album = CoreDataHelper.save(value: albumData.asDict())
        {
            album.userData = albumData.userData
            album.favourites = albumData.favourites
            album.tracks = Set(albumData.tracks.map{$0}) as NSSet
            album.videos = Set(albumData.videos.map{$0}) as NSSet
            
            return album
        }
        
        return nil
    }
}
