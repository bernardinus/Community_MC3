//
//  Track+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import AVFoundation
import CloudKit
import UIKit


struct PrimitiveTrackDataStruct: Codable
{
    var genre:String
    var name:String
    
    var email: String
}

class TrackDataStruct
{
    var record: CKRecord?

    var album:AlbumDataStruct?
    var artistName:String = "artistName"
    var coverImage:UIImage?
    var email: String = "email"
    var fileData: CKAsset?
    var genre:String = "musicGenre"
    var isCoverSong:Bool = false
    var name:String = "musicName"

//    var audioData:AVAudioPlayer?
    
    
    
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
    
//    init()
//    {
//        self.genre = ""
//        self.name = ""
//        self.email = ""
//        self.fileData = CKAsset(fileURL: URL(string: "")!)
//    }
//
    init(genre:String, name:String, email:String, fileURL:URL)
    {
        self.genre = genre
        self.name = name
        self.email = email
        self.fileData = CKAsset(fileURL:fileURL)
    }
    
    func getCKRecord()->CKRecord
    {
        var record = CKRecord(recordType: "Track")
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
