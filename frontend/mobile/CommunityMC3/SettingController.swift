//
//  SettingController.swift
//  CommunityMC3
//
//  Created by Bryanza on 16/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

//import Foundation
import UIKit

func loadAlert() {
//    let alertTitle = NSLocalizedString("Welcome", comment: "")
    let alertTitle = "Tiana Rosser"
    let alertMessage = NSLocalizedString("Are you sure want to sign out?", comment: "")
    let cancelButtonText = NSLocalizedString("Cancel", comment: "")
    let signupButtonText = NSLocalizedString("Sign Out", comment: "")

    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    let cancelAction = UIAlertAction(title: cancelButtonText, style: UIAlertAction.Style.cancel, handler: nil)
    let signupAction = UIAlertAction(title: signupButtonText, style: UIAlertAction.Style.default, handler: nil)
    alert.addAction(cancelAction)
    alert.addAction(signupAction)
//    self.presentViewController(alert, animated: true, completion: nil)
}
