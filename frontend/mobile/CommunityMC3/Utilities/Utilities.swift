//
//  Utilities.swift
//  CommunityMC3
//
//  Created by Bernardinus on 30/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

func openInstagram(username:String)
{
    let instagramURL = URL(string: "instagram://user?username=\(username)")
    if UIApplication.shared.canOpenURL(instagramURL!)
    {
        UIApplication.shared.open(instagramURL!, options: [:], completionHandler: { (success) in
            print("open url \(instagramURL!) status \(success)")
        })
    }
    else
    {
        print("can't open url \(instagramURL!)")
    }
}
