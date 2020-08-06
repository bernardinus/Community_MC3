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
    var accounts: [UserDataStruct]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissView()
        setup()
    }
    
    func setup(){
        
        switchAccountTable.register(UINib(nibName: "SwitchAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "switchCell")
        switchAccountTable.register(UINib(nibName: "AddAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "addCell")
        switchAccountTable.allowsMultipleSelection = true
    }
    
    func dismissView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(dismissViewFunc))
        tap.cancelsTouchesInView = false; view.addGestureRecognizer(tap)
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
            cell.switchAccountImage.image = accounts[indexPath.row].profilePicture
           return cell
        }
    }
    
}
