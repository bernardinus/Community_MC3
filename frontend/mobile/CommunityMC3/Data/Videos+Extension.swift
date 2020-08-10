//
//  Videos+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import AVKit
import CloudKit

class VideosDataStruct
{
    var record:CKRecord? = nil
    
    // ref
    var album:AlbumDataStruct? = nil
    
    
    // normal param
    var artistName:String = "artistName"
    var coverImage:UIImage? = nil
    var email:String = "videoEmail"
    var fileData:CKAsset? = nil
    var genre:String = "videoGenre"
    var isCoverSong:Bool = false
    var name:String = "videoName"
    
    // asset
    var videoData:AVPlayer? = nil
    
    init(record:CKRecord)
    {
        self.record = record
        
        let artistData = record.value(forKey: "artistName")
        if artistData != nil
        {
            self.artistName = artistData as! String
        }


        let coverImageData = record.value(forKey: "coverImage")
        if(coverImageData != nil)
        {
            coverImage = UIImage(data: coverImageData as! Data)
        }
        self.email = record.value(forKey: "email") as! String

        self.fileData = record.value(forKey: "fileData") as? CKAsset

        let genreData = record.value(forKey: "genre")
        if genreData != nil
        {
            self.genre = genreData as! String
        }
        
        let isCoverSongData = record.value(forKey: "isCoverSong")
        var isCoverSongDataIntValue:Int = 0
        if(isCoverSongData != nil )
        {
            isCoverSongDataIntValue = isCoverSongData as! Int
            
            if(isCoverSongDataIntValue == 1)
            {
                self.isCoverSong = true
            }
        }
        
        let nameData = record.value(forKey: "name")
        if(nameData != nil)
        {
            self.name = nameData as! String
        }
    }
    
    init()
    {
        self.genre = ""
        self.name = ""
        self.email = ""
        self.fileData = CKAsset(fileURL: URL(string: "")!)

    }
    
    init(genre: String, name:String, email:String, fileURL:URL)
    {
        self.genre = genre
        self.name = name
        self.email = email
        self.fileData = CKAsset(fileURL:fileURL)
        
    }
    
    func getCKRecord()->CKRecord
    {
        var record = CKRecord(recordType: "Videos")
        record.setValue(nil, forKey: "album")
        record.setValue(genre, forKey: "genre")
        record.setValue(email, forKey: "email")
        record.setValue(name, forKey: "name")
        record.setValue(fileData, forKey: "fileData")
        record.setValue(DataManager.shared().currentUser?.name, forKey: "artistName")
        record.setValue(coverImage?.pngData(), forKey: "coverImage")
        return record
    }
}

struct PrimitiveVideosDataStruct: Codable
{
    // normal param
    var genre:String
    var name:String
    var email:String
}
