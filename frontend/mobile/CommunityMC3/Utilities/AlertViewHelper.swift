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
    case ConfirmExitEditing
    
}

// custom key
//var strKeyMilestone = "#milestone"


class AlertViewHelper
{

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
                
            default:
                let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: rightCompletionHandler)
                alertView.addAction(okAction)
        }
    }
}

