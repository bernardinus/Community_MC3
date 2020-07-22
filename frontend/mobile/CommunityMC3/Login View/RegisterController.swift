//
//  RegisterController.swift
//  CommunityMC3
//
//  Created by Bryanza on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import CoreData
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
        passwordField.placeholder = ""
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
    //        let newTask = Task(context: getViewContext())
        if let newAccount = Account.registerAccount(context: getViewContext(), accountEmail: emailField.text ?? "", accountPassword: passwordField.text ?? "") {
            emailField.text = ""
            passwordField.text = ""
            print(newAccount)
            self.performSegue(withIdentifier: "registerMain", sender: self)
            }
    }
}


extension UIViewController {
    
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
}

extension Account {
    
    static func registerAccount(context: NSManagedObjectContext, accountEmail: String, accountPassword: String) -> Account? {
        let account = Account(context: context)
        account.email = accountEmail
        account.password = accountPassword
//        task.subtask = []
//        guard ((try? context.save()) != nil) else {
//            return nil
//        }
//        return task
        do {
            try context.save()
            return account
        } catch {
            return nil
        }
    }
    
    static func loginAccount(context: NSManagedObjectContext, accountEmail: String, accountPassword: String) -> Account? {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        do {
            let accounts = try context.fetch(request)
            for account in accounts {
                if account.email == accountEmail && account.password == accountPassword {
                    return account
                }
            }
            return nil
        } catch {
            return nil
        }
    }
    
    static func editAccount(context: NSManagedObjectContext, accountEmail: String, accountPassword: String) -> Bool {
//        let request: NSFetchRequest<NSFetchRequestResult> = Account.fetchRequest()
//        let predicate = NSPredicate(format: "taskName BEGINSWITH 'v'")
//        request.predicate = predicate
//        if accountEmail == "" || accountPassword == "" {
//            let deletedRequest = NSBatchDeleteRequest(fetchRequest: request)
//            let result = try? context.execute(deletedRequest)
//            if (result != nil) {
//                let account = Account(context: context)
//                if accountEmail != "" {
//                    account.email = accountEmail
//                }
//                if accountPassword != "" {
//                    account.password = accountPassword
//                }
//                do {
//                   try context.save()
//                   return true
//                } catch {
//                   return false
//                }
//            }
//            return false
//        }else {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        var response = false
        do {
            let accounts = try context.fetch(request)
            for account in accounts {
                if account.email != "" && account.password == accountPassword {
                    account.setValue(accountEmail, forKey: "email")
                    response = true
                }
                if account.email == accountEmail && account.password != "" {
                    account.setValue(accountPassword, forKey: "password")
                    response = true
                }
            }
            return response
        } catch {
            return false
        }
//        }
    }
    
    
    
}
