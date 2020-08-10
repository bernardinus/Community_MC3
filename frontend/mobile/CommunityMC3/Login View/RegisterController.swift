//
//  RegisterController.swift
//  CommunityMC3
//
//  Created by Bryanza on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import CoreData
import CloudKit
import Foundation

class RegisterController: UIViewController {
    
    @IBOutlet weak var signUpTitleLabel: UILabel!
    @IBOutlet weak var signUpDescriptionLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var haveAccountButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordTitleLabel: UILabel!
    @IBOutlet weak var repeatedPasswordField: UITextField!
    var callBack: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalisation()
        passwordField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.navigationController?.view.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
    
    func setLocalisation() {
        emailField.placeholder = NSLocalizedString("Insert Email Here".uppercased(), comment: "")
        passwordField.placeholder = NSLocalizedString("Insert Password Here".uppercased(), comment: "")
        repeatedPasswordField.placeholder = NSLocalizedString("Insert Repeated Password Here".uppercased(), comment: "")
        signUpTitleLabel.text = NSLocalizedString("Sign Up", comment: "")
        signUpDescriptionLabel.text = NSLocalizedString("Sign Up Description".uppercased(), comment: "")
        emailTitleLabel.text = NSLocalizedString("Email Address", comment: "")
        passwordTitleLabel.text = NSLocalizedString("Password", comment: "")
        registerButton.titleLabel?.text = NSLocalizedString("Register Now".uppercased(), comment: "")
        haveAccountButton.titleLabel?.text = NSLocalizedString("Have Account".uppercased(), comment: "")
        confirmPasswordTitleLabel.text = NSLocalizedString("Confirm Password".uppercased(), comment: "")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        //        passwordField.placeholder = ""
        passwordField.isSecureTextEntry = true
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //       self.navigationController?.setNavigationBarHidden(true, animated: animated)
    //       super.viewWillAppear(animated)
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //       self.navigationController?.setNavigationBarHidden(false, animated: animated)
    //       super.viewWillDisappear(animated)
    //    }
    
    //    func SetBackBarButtonCustom()
    //    {
    //        //Back buttion
    //        let btnLeftMenu: UIButton = UIButton()
    //        btnLeftMenu.setImage(UIImage(named: "back_arrow"), for: UIControlState())
    //        btnLeftMenu.addTarget(self, action: #selector(UIViewController.onClcikBack), for: UIControlEvents.touchUpInside)
    //        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
    //        let barButton = UIBarButtonItem(customView: btnLeftMenu)
    //        self.navigationItem.leftBarButtonItem = barButton
    //    }
    //
    //    func onClcikBack()
    //    {
    //        _ = self.navigationController?.popViewController(animated: true)
    //    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        registerToCloudKit()        
    }
    
    func registerToCoreData() {
        //        let newTask = Task(context: getViewContext())
        if let newAccount = Account.registerAccount(context: getViewContext(), accountEmail: emailField.text ?? "", accountPassword: passwordField.text ?? "") {
            emailField.text = ""
            passwordField.text = ""
//            print(newAccount)
            callBack!()
            //        self.performSegue(withIdentifier: "registerMain", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerAccountSegue"
        {
            let vc = segue.destination as! SettingController
            vc.isEditProfile = false
            vc.emailAddr = emailField.text!
            vc.password = passwordField.text!
        }
    }
    
    @IBAction func unwindToRegisterController(_ segue:UIStoryboardSegue)
    {
        
    }
    
    func registerToCloudKit() {
        
        performSegue(withIdentifier: "registerAccountSegue", sender: nil)
        /*
        // 1. buat dulu recordnya
        //        let newRecord = CKRecord(recordType: "Register")
        let newRecord = CKRecord(recordType: "Account")
        
        // 2. set propertynya
        newRecord.setValue(emailField.text ?? "", forKey: "email")
        newRecord.setValue(passwordField.text ?? "", forKey: "password")
        
        // 3. execute save or insert
        let database = CKContainer(identifier: "iCloud.ada.mc3.music").publicCloudDatabase
        //        let database = CKContainer(identifier: "iCloud.com.herokuapp.communitymc3").publicCloudDatabase
        //        print(CKContainer.default())
        database.save(newRecord) { record, error in
            if let err = error {
                print(err.localizedDescription)
            }
            
            print(record)
            
            DispatchQueue.main.async {
                UserDefaults.standard.set(self.emailField.text, forKey: "email")
                //                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                self.callBack!()
                //                self.performSegue(withIdentifier: "registerMain", sender: self)
            }
        }
        */
    }
}




