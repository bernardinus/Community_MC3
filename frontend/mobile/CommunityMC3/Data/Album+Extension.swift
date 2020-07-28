//
//  Album.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

struct AlbumDataStruct
{
    var cover:UIImage?
    var name:String
}

/*
 extension Album
 {
 
 
 static func createAlbum(albumData:AlbumDataStruct) -> Album?
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
 */
