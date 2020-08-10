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
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var forgotPasswordDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalisation()
    }
    
    func setLocalisation() {
        emailField.placeholder = NSLocalizedString("Insert Email Here".uppercased(), comment: "")
        emailTitleLabel.text = NSLocalizedString("Email Address", comment: "")
        submitButton.titleLabel?.text = NSLocalizedString("Submit".uppercased(), comment: "")
        forgotPasswordLabel.text = NSLocalizedString("Forgot Password".uppercased(), comment: "")
        forgotPasswordDescription.text = NSLocalizedString("Forgot Desc".uppercased(), comment: "")
    }
    
    @IBAction func submitForgotPassword(_ sender: Any) {
        AlertViewHelper.creteAlert(self, title: "Recovery Password", msg: "An email for reseting the password has been sent")
    }
    
}
