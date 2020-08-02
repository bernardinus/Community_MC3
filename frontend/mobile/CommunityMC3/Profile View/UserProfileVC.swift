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
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    var isPersonalProfile:Bool = true
    
    var userData:UserDataStruct?
    
    var cVC:CarouselPageViewController?
    
    var showcaseVC:SecondPageVC?
    
    var aboutVC:FirstPageVC?
    
    
    var isUploadVideo = false
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var actionSheet:UIAlertController = UIAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followButton.layer.cornerRadius = 10
        contactButton.layer.cornerRadius = 10
        setupActionSheet()
        // Do any additional setup after loading the view.
        firstTabButton.alpha = 1
        secondTabButton.alpha = 0.5
        cVC?.moveToPage(index: 0)
        
        followButton.isHidden = isPersonalProfile
        contactButton.isHidden = isPersonalProfile
    }
    
    func updateLayout()
    {
        if let loadEmail = userDefault.string(forKey: "email"){
            userNameLabel.text = loadEmail
        }

        userData = UserDataStruct(DataManager.shared().currentUser!)
        print("Name :\(userData!.name!)")
        
        // name
        userNameLabel.text = userData?.name
        
        
        // about VC
        aboutVC?.updateData(
            genre: userData!.genre!,
            phoneNumber: userData!.phoneNumber!,
            socialMedia: userData!.instagram!
        )
        
        // showcase VC
        
    }
    
    @IBAction func unwindToUserProfile(_ segue:UIStoryboardSegue)
    {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        

        super.viewDidAppear(animated)
        
        
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
    
    func signOut(action:UIAlertAction)
    {
        DataManager.shared().logout()
        self.performSegue(withIdentifier: "logoutUser", sender: nil)

    }
    
    func setupActionSheet()
    {
        
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive, handler: signOut)
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
        
        aboutVC = cVC!.items[0] as? FirstPageVC
        
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
        
        super.viewWillAppear(animated)
        
        
        
        updateLayout()
        
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

