//
//  AccountController.swift
//  Allegro
//
//  Created by Bryanza on 05/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class AccountController: UIViewController {
    
    @IBOutlet var switchAccountTable: UITableView!
    var accounts: [PrimitiveUserDataStruct]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dismissView()
        setup()
    }
    
    func setup(){
        
        switchAccountTable.register(UINib(nibName: "SwitchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "switchCell")
        switchAccountTable.register(UINib(nibName: "AddAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "addCell")
        switchAccountTable.allowsMultipleSelection = true
    }
    
    func dismissView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(dismissViewFunc))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissViewFunc(){
        print("dismissView")
        view.endEditing(true)
    }
    
    @IBAction func cancelSwitchAccount(_ sender: UIButton) {
        let userProfileVC = UserProfileVC()
        userProfileVC.overlayView.removeFromSuperview()
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension AccountController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == accounts.count)
        {
            let cell = switchAccountTable.dequeueReusableCell(withIdentifier: "addCell") as! AddAccountTableViewCell
            cell.addAccountLabel.text = NSLocalizedString("Add Account".uppercased(), comment: "")
            return cell
        }else{
            let cell = switchAccountTable.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchAccountTableViewCell
            cell.switchAccountName.text = accounts[indexPath.row].name
            cell.switchAccountRole.text = accounts[indexPath.row].role
            if let data = NSData(contentsOf: URL(fileURLWithPath: accounts[indexPath.row].profilePicture)) {
                cell.switchAccountImage.image = UIImage(data: data as Data)
            }
           return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == accounts.count)
        {
            self.performSegue(withIdentifier: "addAccount", sender: nil)
        }else{
            if accounts[indexPath.row].email != "" && accounts[indexPath.row].email != UserDefaults.standard.string(forKey: "email") {
                DataManager.shared().currentUser?.email = accounts[indexPath.row].email
                DataManager.shared().currentUser?.name = accounts[indexPath.row].name
                DataManager.shared().currentUser?.role = accounts[indexPath.row].role
                if let data = NSData(contentsOf: URL(fileURLWithPath: accounts[indexPath.row].profilePicture)) {
                    DataManager.shared().currentUser?.profilePicture = UIImage(data: data as Data)
                }
                UserDefaults.standard.set(accounts[indexPath.row].email, forKey: "email")
                UserDefaults.standard.synchronize()
                let data:[String: Bool] = ["data": true]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: data)
            }
            if let loadEmail = UserDefaults.standard.string(forKey: "email"){
              print("changed", loadEmail)
//                let userProfileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileStoryboard") as! UserProfileVC
                //            let userProfileVC = UserProfileVC.shared
//                userProfileVC.userNameLabel.text = loadEmail
           }
            let userProfileVC = UserProfileVC()
            userProfileVC.overlayView.removeFromSuperview()
            

            dismiss(animated: true, completion: nil)
        }
    }
    
}
