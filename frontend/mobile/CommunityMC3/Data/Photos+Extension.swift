//
//  Photos+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class PhotoDataStruct
{
    //    var fileData:UIImage?
    
    var record:CKRecord? =  nil
    var photosData: UIImage?
    var email: String? = nil
//    var genre:String
//    var name: String
    
    init(record:CKRecord)
    {
        self.record = record
        
        let data = record.value(forKey: "photosData")
        if( data != nil)
        {
            photosData = UIImage(data: data as! Data)
        }
        
//        genre = ""
//        name = ""

    }
    
    init()
    {
        photosData = UIImage(color: .red)
        email = ""
//        genre = ""
//        name = ""
    }
    
    func getCKRecord()->CKRecord
    {
        var newRecord = CKRecord(recordType: "Photos")
        newRecord.setValue(email, forKey: "email")
        newRecord.setValue(photosData?.pngData(), forKey: "photosData")
        return newRecord
    }
}

struct ProfilePictureDataStruct {
    var fileURL: URL
    var email: String
}
