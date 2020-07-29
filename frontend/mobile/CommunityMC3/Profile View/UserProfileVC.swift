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
    
    var cVC:CarouselPageViewController?
    
    var showcaseVC:SecondPageVC?
    var isUploadVideo = false
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var actionSheet:UIAlertController = UIAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionSheet()
        updateLayout()
        // Do any additional setup after loading the view.
        firstTabButton.alpha = 1
        secondTabButton.alpha = 0.5
        cVC?.moveToPage(index: 0)
        
        
        
    }
    
    func updateLayout()
    {
        if let loadEmail = userDefault.string(forKey: "email"){
            userNameLabel.text = loadEmail
        }
    }
    
    @IBAction func unwindToUserProfile(_ segue:UIStoryboardSegue)
    {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"
        {
            print("containerSegue")
            cVC = (segue.destination as! CarouselPageViewController)
        }
        else if segue.identifier == "selectFileSegue"
        {
            let selectVC = segue.destination as! SelectFileView
            selectVC.isUploadVideo = isUploadVideo
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
                                       handler: {
                                        action in
                                        self.performSegue(withIdentifier: "editProfileSegue", sender: nil) }
        )
        actionSheet.addAction(editAction)
        
        let shareAction = UIAlertAction(title: "Share", style: .default)
        actionSheet.addAction(shareAction)
        
        let uploadMusic = UIAlertAction(title: "Upload Music", style: .default,
                                         handler: {
                                            action in
                                            self.isUploadVideo = false
                                            self.performSegue(withIdentifier: "selectFileSegue", sender: nil) }
        )
        actionSheet.addAction(uploadMusic)
        
        let uploadVideo = UIAlertAction(title: "Upload Video", style: .default,
                                         handler: {
                                            action in
                                            self.isUploadVideo = true
                                            self.performSegue(withIdentifier: "selectFileSegue", sender: nil) }
        )
        actionSheet.addAction(uploadVideo)
        
        let uploadPhotos = UIAlertAction(title: "Upload Photos", style: .default,
                                         handler: {
                                            action in
                                            print("uploadPhotos") }
        )
        actionSheet.addAction(uploadPhotos)
        
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
        
        showcaseVC = cVC!.items[1] as? SecondPageVC
        showcaseVC?.showcaseVideoSegue = {
            self.performSegue(withIdentifier: "showcaseVideoSegue", sender: nil)
        }
        showcaseVC?.showcasePhotoSegue = {
            self.performSegue(withIdentifier: "showcasePhotoSegue", sender: nil)
        }
        showcaseVC?.showcaseMusicSegue = {
            self.performSegue(withIdentifier: "showcaseMusicSegue", sender: nil)
        }
        
    }
    
    
    @IBAction func menuButtonTouched(_ sender: Any) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func firstPageTapped(_ sender: Any) {
        firstTabButton.alpha = 1
        secondTabButton.alpha = 0.5
        
        print(cVC?.a as Any)
        cVC?.moveToPage(index: 0)
    }
    
    @IBAction func secondPageTapped(_ sender: Any) {
        firstTabButton.alpha = 0.5
        secondTabButton.alpha = 1
        
        print(cVC?.a as Any)
        cVC?.moveToPage(index: 1)
    }
}


extension UserProfileVC : UIActionSheetDelegate
{
    
}

