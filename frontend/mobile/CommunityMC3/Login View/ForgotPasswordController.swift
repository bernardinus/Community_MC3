//
//  ForgotPasswordController.swift
//  Allegro
//
//  Created by Bernardinus on 10/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordController:UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitForgotPassword(_ sender: Any) {
        AlertViewHelper.creteAlert(self, title: "Recovery Password", msg: "An email for reseting the password has been sent")
    }
    
}
