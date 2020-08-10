//
//  AlertViewHelper.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

enum AlertViewType
{
    case OK
    case Error
    case ConfirmExitEditing
    case SignOut
}

// custom key
//var strKeyMilestone = "#milestone"
var strKeyErrorMSG = "#errorMSG"
var strKeyOK_TITLE = "#ok_TITLE"
var strKeyOK_MSG = "#ok_MSG"


class AlertViewHelper
{
    var a:(()->Void)? = nil
    
    class func creteAlert(_ view:UIViewController, title:String, msg:String)
    {
        let alert:UIAlertController = AlertViewHelper.createAlertView(type: .OK,
                                        rightHandler: nil,
                                        leftHandler: nil,
                                        replacementString: [strKeyOK_MSG : msg, strKeyOK_TITLE:title]
        )
        view.present(alert,animated: true, completion: nil)
    }
    
    class func creteErrorAlert(errorString:String, view:UIViewController) -> UIAlertController
    {
        let alert:UIAlertController = AlertViewHelper.createAlertView(type: .Error,
                                        rightHandler: nil,
                                        leftHandler: nil,
                                        replacementString: [strKeyErrorMSG : errorString]
        )
        view.present(alert,animated: true, completion: nil)
        return alert
    }
    
    class func createAlertView(type:AlertViewType,
                               rightHandler:((UIAlertAction) -> Void)? = nil,
                               leftHandler:((UIAlertAction) -> Void)? = nil,
                               replacementString:[String:String] = [:]
    ) -> UIAlertController
    {
        var alertView:UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        loadAlertCopy(type, &(alertView.title)!, &(alertView.message)!)
        loadAlertAction(type, &alertView, rightCompletionHandler: rightHandler, leftCompletionHandler: leftHandler)
        
        if replacementString.count > 0
        {
            for item in replacementString
            {
                alertView.title = alertView.title?.replacingOccurrences(of: item.key, with: item.value)
                alertView.message = alertView.message?.replacingOccurrences(of: item.key, with: item.value)
            }
        }
        
        
        return alertView
    }
    
    internal class func loadAlertCopy(_ type:AlertViewType,_ alertTitle:inout String, _ alertMSG:inout String)
    {
        switch type
        {
            
        // Approve project
        case .ConfirmExitEditing:
            alertTitle = "Exit edit mode"
            alertMSG = "You will lose all your edited data"
        case .Error:
            alertTitle = "Error"
            alertMSG = strKeyErrorMSG
        case .OK:
            alertTitle = strKeyOK_TITLE
            alertMSG = strKeyOK_MSG
        case .SignOut :
            alertTitle = "Sign out"
            alertMSG = "Are you sure?"
            
        }
        
    }
    
    internal class func loadAlertAction(_ type:AlertViewType,
                                        _ alertView:inout UIAlertController,
                                        rightCompletionHandler:((UIAlertAction) -> Void)?,
                                        leftCompletionHandler:((UIAlertAction) -> Void)?
    )
    {
        switch type
        {
        case .ConfirmExitEditing:
            let rightAction:UIAlertAction = UIAlertAction(title: "Yes", style: .default, handler: rightCompletionHandler)
            alertView.addAction(rightAction)
            let leftAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: leftCompletionHandler)
            alertView.addAction(leftAction)
        case .SignOut:
            let rightAction:UIAlertAction = UIAlertAction(title: "Yes", style: .destructive, handler: rightCompletionHandler)
            alertView.addAction(rightAction)
            let leftAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: leftCompletionHandler)
            alertView.addAction(leftAction)
        default:
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: rightCompletionHandler)
            alertView.addAction(okAction)
        }
    }
}

