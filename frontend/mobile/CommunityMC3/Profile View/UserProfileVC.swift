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
    @IBOutlet weak var otherMenu: UIBarButtonItem!
    @IBOutlet weak var uploadMediaButton: UIButton!
    var isPersonalProfile:Bool = true
    
    var userData:UserDataStruct?
    
    var cVC:CarouselPageViewController?
    
    var showcaseVC:SecondPageVC?
    
    var aboutVC:FirstPageVC?
    
    
    var isUploadVideo = false
    var phoneNumber = "087875732888"
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var actionSheet:UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
    
    var actionSheetToCall: UIAlertController = UIAlertController(title: "Contact Me", message: "", preferredStyle: .actionSheet)
    
    let userDefault = UserDefaults.standard
    
    var imgPicker:ImagePicker?
    
    let overlayView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadEmail = userDefault.string(forKey: "email"){
            userNameLabel.text = loadEmail
        }
        imgPicker = ImagePicker(presentationController: self, delegate: self)
        loadLocalisation()
        followButton.layer.cornerRadius = 10
        contactButton.layer.cornerRadius = 10
        setupActionSheet()
        setupActionSheetToCall()

        // Do any additional setup after loading the view.
        firstTabButton.alpha = 1
        secondTabButton.alpha = 0.5
        cVC?.moveToPage(index: 0)
        
        followButton.isHidden = isPersonalProfile
        contactButton.isHidden = isPersonalProfile
        uploadMediaButton.isHidden = !isPersonalProfile

        if(!isPersonalProfile)
        {
            otherMenu.image = UIImage(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
            otherMenu.isEnabled = false
        }
        else
        {
            otherMenu.image = UIImage(systemName: "ellipsis")
            otherMenu.isEnabled = true
        }
    }
    
    func loadLocalisation() {
        followButton.titleLabel?.text = NSLocalizedString("Follow".uppercased(), comment: "")
        contactButton.titleLabel?.text = NSLocalizedString("Contact".uppercased(), comment: "")
        firstTabButton.titleLabel?.text = NSLocalizedString("About", comment: "")
        secondTabButton.titleLabel?.text = NSLocalizedString("Showcase".uppercased(), comment: "")
    }
    
    @IBAction func contactButtonTouched(_ sender: Any) {
        self.present(actionSheetToCall, animated: true, completion: nil)
        
    }
    
    @IBAction func uploadMediaButtonTouched(_ sender: UIButton) {
        
        let uploadPanelVC = storyboard?.instantiateViewController(identifier: "UploadPanelView") as! UploadPanelViewController
        uploadPanelVC.transitioningDelegate = self
        uploadPanelVC.modalPresentationStyle = .custom
        uploadPanelVC.modalTransitionStyle = .coverVertical
        uploadPanelVC.view.layer.cornerRadius = 34
        
//        performSegue(withIdentifier: "uploadPanel", sender: self)
        self.present(uploadPanelVC, animated: true, completion: nil)
    }
    
    
    func updateLayout()
    {
        if let loadEmail = userDefault.string(forKey: "email"){
            userNameLabel.text = loadEmail
        }
        

//        userData = UserDataStruct(DataManager.shared().currentUserRec!)
        userData = DataManager.shared().currentUser
        print("Name :\(userData!.name!)")
        
        // name
        userNameLabel.text = userData?.name
        
        
        
        // about VC
        aboutVC?.updateData(
            genre: userData!.genre!,
            phoneNumber: userData!.phoneNumber!,
            socialMedia: userData!.instagram!
        )
        aboutVC?.aboutTableView.reloadData()
        
        // showcase VC
        showcaseVC?.updateData(tracks: userData?.musics,
                               videos: userData?.videos,
                               photos: userData?.photos)
        
    }
    
    @IBAction func unwindToUserProfile(_ segue:UIStoryboardSegue)
    {
        print("UNWIND to Profile \(segue.identifier) \(segue.destination)")
        updateLayout()
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
        else if segue.identifier == "editProfileSegue"
        {
            let vc = segue.destination as! SettingController
            vc.isEditProfile = true
        }
        else if segue.identifier == "trackPlayerSegue" {
            if let trackPlayerPage = segue.destination as? TrackPlayerViewController {
                trackPlayerPage.track = sender as? TrackDataStruct
            }
        }
        else if segue.identifier == "videoPlayerSegue" {
            if let videoPlayerPage = segue.destination as? VideoPlayerViewController
            {
                videoPlayerPage.video = sender as? VideosDataStruct
            }
        }
    }
    
    func signOut(action:UIAlertAction)
    {
        DataManager.shared().logout()
        self.performSegue(withIdentifier: "logoutUser", sender: nil)

    }
    
    func setupActionSheet()
    {
        
        
        let signOutAction = UIAlertAction(title: NSLocalizedString("Sign Out", comment: ""), style: .destructive, handler: signOut)
        actionSheet.addAction(signOutAction)
        
        let editAction = UIAlertAction(title: NSLocalizedString("Edit".uppercased(), comment: ""), style: .default,
                                       handler: {
                                        action in
                                        self.performSegue(withIdentifier: "editProfileSegue", sender: nil) }
        )
        actionSheet.addAction(editAction)
        
        let switchAccountAction = UIAlertAction(title: NSLocalizedString("Switch Account".uppercased(), comment: ""), style: .default) { (action) in
            let switchAccountVC = self.storyboard?.instantiateViewController(identifier: "SwitchAccountVC") as! AccountController
            var temp = [UserDataStruct]()
            temp.append(self.userData!)
            switchAccountVC.accounts = temp
            switchAccountVC.transitioningDelegate = self
            switchAccountVC.modalPresentationStyle = .custom
            switchAccountVC.modalTransitionStyle = .coverVertical
            switchAccountVC.view.layer.cornerRadius = 34
            
            self.present(switchAccountVC, animated: true, completion: nil)
        }
        actionSheet.addAction(switchAccountAction)
        
        let shareAction = UIAlertAction(title: NSLocalizedString("Share".uppercased(), comment: ""), style: .default)
        actionSheet.addAction(shareAction)
        
        let uploadMusic = UIAlertAction(title: NSLocalizedString("Upload Music".uppercased(), comment: ""), style: .default,
                                         handler: {
                                            action in
                                            self.isUploadVideo = false
                                            self.performSegue(withIdentifier: "selectFileSegue", sender: nil) }
        )
        actionSheet.addAction(uploadMusic)
        
        let uploadVideo = UIAlertAction(title: NSLocalizedString("Upload Video".uppercased(), comment: ""), style: .default,
                                         handler: {
                                            action in
                                            self.isUploadVideo = true
                                            self.performSegue(withIdentifier: "selectFileSegue", sender: nil) }
        )
        actionSheet.addAction(uploadVideo)
        
        let uploadPhotos = UIAlertAction(title: NSLocalizedString("Upload Photos".uppercased(), comment: ""), style: .default,
                                         handler: {
                                            action in
                                            self.imgPicker?.present(from: self.view) }
        )
        actionSheet.addAction(uploadPhotos)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
        actionSheet.addAction(cancelAction)
    }
    
    func setupActionSheetToCall(){
        let callAction = UIAlertAction(title: "Make a Phone Call", style: .default, handler: { action in callPhoneNumber(phoneNumber: self.userData!.phoneNumber!)
            
        })
        actionSheetToCall.addAction(callAction)
        
        let openInstagramAction = UIAlertAction(title: "Open Instagram", style: .default, handler: {
            action in openInstagram(username: self.userData!.instagram!)
        })
        actionSheetToCall.addAction(openInstagramAction)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
        actionSheetToCall.addAction(cancelAction)
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
        showcaseVC?.playMusicSegue = { sender in
            self.performSegue(withIdentifier: "trackPlayerSegue", sender: sender)
        }
        showcaseVC?.playVideoSegue = { sender in
            self.performSegue(withIdentifier: "videoPlayerSegue", sender: sender)
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
        showcaseVC?.playMusicSegue = { sender in
            self.performSegue(withIdentifier: "trackPlayerSegue", sender: sender)
        }
        showcaseVC?.playVideoSegue = { sender in
            self.performSegue(withIdentifier: "videoPlayerSegue", sender: sender)
        }
        
        updateLayout()
        
    }
}


extension UserProfileVC : UIActionSheetDelegate, UIViewControllerTransitioningDelegate
{

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
           return OverlayPresentationController(presentedViewController:presented, presenting:presenting)
    }
}

extension UserProfileVC:ImagePickerDelegate
{
    func didSelect(image: UIImage?)
    {
//        coverImage?.image = image
        var photoData = PhotoDataStruct()
        photoData.email = DataManager.shared().currentUser?.email
        photoData.photosData = image
        
        DataManager.shared().UploadNewPhoto(photoData:photoData) { (isSuccess, errorString) in
            if isSuccess
            {
                print("Upload Photo File Success")
                
                
//                    self.dismiss(animated: true, completion: nil)
                DispatchQueue.main.async {
                    self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                }
                AlertViewHelper.createAlertView(type: .OK, rightHandler:nil, leftHandler: nil, replacementString: [strKeyOK_MSG:"Upload Photo File Success"])
                

            }
            else
            {
                print("Upload Photo File Failed")
                AlertViewHelper.creteErrorAlert(errorString: "Upload Photo File Failed \(errorString)", view: self)
            }
        }
    }
}

class OverlayPresentationController: UIPresentationController {

    private let dimmedBackgroundView = UIView()
    private let height: CGFloat = 450

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.dimmedBackgroundView.addGestureRecognizer(tapGestureRecognizer)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        var frame =  CGRect.zero
        if let containerBounds = containerView?.bounds {
            frame = CGRect(x: 0,
                           y: containerBounds.height/2.3,
                           width: containerBounds.width,
                           height: containerBounds.height/1.5)
        }
        return frame
    }

    override func presentationTransitionWillBegin() {
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            containerView.addSubview(self.dimmedBackgroundView)
            self.dimmedBackgroundView.backgroundColor = .black
            self.dimmedBackgroundView.frame = containerView.bounds
            self.dimmedBackgroundView.alpha = 0
            coordinator.animate(alongsideTransition: { _ in
                self.dimmedBackgroundView.alpha = 0.5
            }, completion: nil)
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        self.dimmedBackgroundView.removeFromSuperview()
    }

    @objc private func backgroundTapped() {
       self.presentedViewController.dismiss(animated: true, completion: nil)
    }


}
