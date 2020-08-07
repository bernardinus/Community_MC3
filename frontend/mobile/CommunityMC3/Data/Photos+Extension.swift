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
    
    var photosData: UIImage?
    var email: String? = nil
//    var genre:String
//    var name: String
    
    init(record:CKRecord)
    {
        let data = record.value(forKey: "photosData")
        if( data != nil)
        {
            photosData = UIImage(data: data as! Data)
            email = record.value(forKey: "email") as! String
        }
        else
        {
            
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
        var record = CKRecord(recordType: "Photos")
        record.setValue(email, forKey: "email")
        record.setValue(photosData?.pngData(), forKey: "photosData")
        return record
    }
}

struct ProfilePictureDataStruct {
    var fileURL: URL
    var email: String
}
