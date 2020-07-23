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
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        // Do any additional setup after loading the view.
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
        print(newAccount)
        self.performSegue(withIdentifier: "registerMain", sender: self)
        }
    }
    
    func registerToCloudKit() {
         // 1. buat dulu recordnya
        let newRecord = CKRecord(recordType: "Register")

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
                self.performSegue(withIdentifier: "registerMain", sender: self)
            }
        }
    }
}




