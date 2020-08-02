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

func setupUIViewForGenre(view:UIView, genre:String)
{
    view.layer.borderWidth = 1.5
    view.layer.cornerRadius = 12
    view.layer.borderColor = genreBorderColor[genre]
}

func genreBorderColor(genre:String) -> CGColor
{
    var color:CGColor? = nil
    
    switch genre
    {
    case "RnB":
        color = #colorLiteral(red: 0, green: 0.768627451, blue: 0.5490196078, alpha: 1)
    case "Jazz":
        color = #colorLiteral(red: 0.4117647059, green: 0.4745098039, blue: 0.9725490196, alpha: 1)
    case "Pop":
        color = #colorLiteral(red: 0, green: 0.5176470588, blue: 0.9568627451, alpha: 1)
    case "Rock":
        color = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    case "Acoustic":
        color = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    case "Blues":
        color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    default:
        color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    return color!
}

let genreBorderColor:[String:CGColor] = [
    "RnB": #colorLiteral(red: 0, green: 0.768627451, blue: 0.5490196078, alpha: 1),
    "Jazz": #colorLiteral(red: 0.4117647059, green: 0.4745098039, blue: 0.9725490196, alpha: 1),
    "Pop": #colorLiteral(red: 0, green: 0.5176470588, blue: 0.9568627451, alpha: 1),
    "Rock": #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
    "Acoustic": #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),
    "Blues": #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
]
