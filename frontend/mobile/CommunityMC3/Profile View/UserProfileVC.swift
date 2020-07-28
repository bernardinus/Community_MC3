//
//  UserProfileVC.swift
//  CommunityMC3
//
//  Created by Theofani on 24/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var firstTabButton: UIButton!
    @IBOutlet weak var secondTabButton: UIButton!
    
    var userData:UserDataStruct?
    
    var vc:CarouselPageViewController?
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var actionSheet:UIAlertController = UIAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadEmail = userDefault.string(forKey: "email"){
            userNameLabel.text = loadEmail
        }
        setupActionSheet()
        // Do any additional setup after loading the view.
        firstTabButton.alpha = 1
        secondTabButton.alpha = 0.5
        vc?.moveToPage(index: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"
        {
            print("containerSegue")
            vc = (segue.destination as! CarouselPageViewController)
        }
    }
    
    func setupActionSheet()
    {
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive, handler: {
            (action: UIAlertAction) in
            self.userDefault.removeObject(forKey: "email")
            self.performSegue(withIdentifier: "logoutUser", sender: self)
        })
        actionSheet.addAction(signOutAction)
        
        let editAction = UIAlertAction(title: "Edit", style: .default,
                                       handler: { action in
                                        self.performSegue(withIdentifier: "editProfileSegue", sender: nil)
        }
        )
        actionSheet.addAction(editAction)
        
        let shareAction = UIAlertAction(title: "Share", style: .default)
        actionSheet.addAction(shareAction)
        
        let uploadAction = UIAlertAction(title: "Upload", style: .default,
                                         handler: { action in
                                            self.performSegue(withIdentifier: "selectFileSegue", sender: nil)
        }
        )
        actionSheet.addAction(uploadAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelAction)
    }
    
    @objc func returnToExplorerView()
    {
        performSegue(withIdentifier: "unwindFromUserProfile", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage(color: .white, size: CGSize(width: 1, height: 1))
        super.viewWillAppear(animated)
        
        //        let navigationBar = navigationController?.navigationBar
        //        let navigationBarAppearence = UINavigationBarAppearance()
        //        navigationBarAppearence.shadowColor = .clear
        //        navigationBar?.scrollEdgeAppearance = navigationBarAppearence
        //        navigationItem.rightBarButtonItems![0].setBackgroundImage(nil, for: .disabled, barMetrics: .default)
        //
        
    }
    
    
    @IBAction func menuButtonTouched(_ sender: Any) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func firstPageTapped(_ sender: Any) {
        firstTabButton.alpha = 1
        secondTabButton.alpha = 0.5
        
        print(vc?.a as Any)
        vc?.moveToPage(index: 0)
    }
    
    @IBAction func secondPageTapped(_ sender: Any) {
        firstTabButton.alpha = 0.5
        secondTabButton.alpha = 1
        
        print(vc?.a as Any)
        vc?.moveToPage(index: 1)
        
    }
}


extension UserProfileVC : UIActionSheetDelegate
{
    
}

