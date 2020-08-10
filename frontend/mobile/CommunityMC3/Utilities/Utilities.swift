//
//  Utilities.swift
//  CommunityMC3
//
//  Created by Bernardinus on 30/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

func openInstagram(username:String)
{
    let instagramURL = URL(string:"instagram://user?username=\(username)")
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

func sendMessageInWhatsApp(message:String)
{
    let whatsappURL = URL(string:"whatsapp://send?text=\(message)")
    if UIApplication.shared.canOpenURL(whatsappURL!)
    {
        UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: { (success) in
            print("open url \(whatsappURL!) status \(success)")
        })
    }
    else
    {
        print("can't open url \(whatsappURL!)")
    }
}

func callPhoneNumber(phoneNumber:String)
{
    let phoneNumberURL = URL(string:"tel://\(phoneNumber)")
    if UIApplication.shared.canOpenURL(phoneNumberURL!)
    {
        UIApplication.shared.open(phoneNumberURL!, options: [:], completionHandler: { (success) in
            print("open url \(phoneNumberURL!) status \(success)")
        })
    }
    else
    {
        print("can't open url \(phoneNumberURL!)")
    }
}


func setupUIViewForGenre(view:UIView, genre:String)
{
    view.layer.borderWidth = 1.5
    view.layer.cornerRadius = 12
    view.layer.borderColor = genreBorderColor[genre]
}

/*
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
        color = #colorLiteral(red: 0.7019607843, green: 0, blue: 0.09411764706, alpha: 1)
    case "Rock":
        color = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    case "Acoustic":
        color = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    case "Blues":
        color = #colorLiteral(red: 0.07843137255, green: 0.2745098039, blue: 0.737254902, alpha: 1)
    default:
        color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    return color!
}
 */

let genreBorderColor:[String:CGColor] = [
    "RnB": #colorLiteral(red: 0, green: 0.768627451, blue: 0.5490196078, alpha: 1),
    "Jazz": #colorLiteral(red: 0.4117647059, green: 0.4745098039, blue: 0.9725490196, alpha: 1),
    "Pop": #colorLiteral(red: 0.7019607843, green: 0, blue: 0.09411764706, alpha: 1),
    "Rock": #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
    "Acoustic": #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),
    "Blues": #colorLiteral(red: 0.07843137255, green: 0.2745098039, blue: 0.737254902, alpha: 1),
]

// to generate video thumbnail
func generateThumbnail(path: URL) -> UIImage? {
    do {
        let asset = AVURLAsset(url: path, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 5, timescale: 1), actualTime: nil)
        let thumbNail = UIImage(cgImage: cgImage)
        return thumbNail
    } catch let error {
        print("*** Error generating thumbnail: \(error.localizedDescription)")
        return nil
    }
}


