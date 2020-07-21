//
//  LoginController.swift
//  CommunityMC3
//
//  Created by Bryanza on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        passwordField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        passwordField.placeholder = ""
        passwordField.isSecureTextEntry = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//       self.navigationController?.setNavigationBarHidden(true, animated: animated)
//       super.viewWillAppear(animated)
//    //           if(flag==0){
//    //               tutor1View.alpha = 1
//    //           }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//       self.navigationController?.setNavigationBarHidden(false, animated: animated)
//       super.viewWillDisappear(animated)
//    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        switch sender {
        case loginButton:
            if let oldAccount = Account.loginAccount(context: getViewContext(), accountEmail: emailField.text ?? "", accountPassword: passwordField.text ?? "") {
                emailField.text = ""
                passwordField.text = ""
                print(oldAccount)
                self.performSegue(withIdentifier: "loginMain", sender: self)
            }
        default:
            return
        }
    }
    


}
