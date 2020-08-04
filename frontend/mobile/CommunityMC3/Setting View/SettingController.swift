//
//  SettingController.swift
//  CommunityMC3
//
//  Created by Bryanza on 16/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

//import Foundation
import UIKit
import CloudKit

class SettingController: UIViewController {
    
    @IBOutlet weak var settingTitleLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var instagramField: UITextField!
    
    var isEditProfile:Bool = true
    var emailAddr:String = ""
    var password:String = ""
    var selectedGenre:String = ""
    
    //    let documentController = DocumentTableViewController.shared
    let uploadController = UploadController.shared
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        
//        let uploadTap = UITapGestureRecognizer(target: self, action: #selector(self.handleUploadTap(_:)))
//        settingImage.addGestureRecognizer(uploadTap)
//        menuButton.isHidden = !isEditProfile
        if let loadEmail = userDefault.string(forKey: "email"){
            emailField.text = loadEmail
        }
        handleLocalisation()
        
        let pickerView:UIPickerView = UIPickerView()
        pickerView.delegate = self
        genreField?.delegate = self
        genreField?.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(title: NSLocalizedString("Done".uppercased(), comment: ""), style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([flexibleSpace,button], animated: true)
        toolBar.isUserInteractionEnabled = true
        genreField!.inputAccessoryView = toolBar
        
        /*
                documentController.getProfilesFromCloudKit { (profiles) in
                    for profile in profiles {
                        print(profile.name, profile.email, profile.genre)
                    }
                }
                uploadController.getPhotosFromCloudKit { (photos) in
                    for photo in photos {
                        if photo.email == self.emailField.text {
                            if let data = NSData(contentsOf: photo.fileURL) {
                                DispatchQueue.main.async {
                                    self.settingImage.image = UIImage(data: data as Data)
                                }
                           }
                        }
                    }
                }
 */
        /*
        uploadController.getUsersDataFromCloudKit { (usersData) in
            for userData in usersData {
                if userData.email == self.emailField.text {
                    if let data = NSData(contentsOf: userData.fileURL!) {
                        DispatchQueue.main.async {
                            self.nameField.text = userData.name
                            self.genreField.text = userData.genre
                            self.settingImage.image = UIImage(data: data as Data)
                        }
                    }
                }
            }
        }
 */
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(isEditProfile)
        {
            updateField()
        }
        else
        {
            nameField.text = ""
            genreField.text = ""
            emailField.text = emailAddr
            
            settingImage.image = UIImage(systemName: "person.circle")
            phoneNumberField.text = ""
            instagramField.text = ""
        }
        super.viewWillAppear(animated)
    }
    
    func updateField()
    {
        let data:UserDataStruct = DataManager.shared().currentUser!
        nameField.text = data.name
        genreField.text = data.genre
        settingImage.image = data.profilePicture
        phoneNumberField.text = data.phoneNumber
        instagramField.text = data.instagram
    }
    
    @IBAction func chooseGenre(_ sender: UIButton) {
        let genreProfileVC = storyboard?.instantiateViewController(identifier: "GenreProfileVC") as! GenreProfileController
        genreProfileVC.transitioningDelegate = self
        genreProfileVC.modalPresentationStyle = .custom
        genreProfileVC.modalTransitionStyle = .coverVertical
        genreProfileVC.view.layer.cornerRadius = 34
        
        self.present(genreProfileVC, animated: true, completion: nil)
    }
    
    func handleLocalisation()  {
        settingTitleLabel.text = NSLocalizedString("Settings", comment: "")
        nameTitleLabel.text = NSLocalizedString("Name".uppercased(), comment: "")
        emailTitleLabel.text = NSLocalizedString("Email".uppercased(), comment: "")
        genreTitleLabel.text = NSLocalizedString("Genre", comment: "")
        saveButton.titleLabel?.text = NSLocalizedString("Save", comment: "")
        phoneNumberLabel.text = NSLocalizedString("Phone Number", comment: "")
        instagramLabel.text = NSLocalizedString("Instagram", comment: "")
        
    }
    @IBAction func backButtonTouched(_ sender: Any) {
        handleUnwind()
    }
    
    func handleUnwind()
    {
        if(isEditProfile)
        {
            performSegue(withIdentifier: "unwindToUserProfile", sender: nil)
        }
        else
        {
            performSegue(withIdentifier: "unwindToRegister", sender: nil)
        }
    }
    
    @objc func handleUploadTap(_ sender: UITapGestureRecognizer? = nil) {
        self.openCameraAndLibrary()
    }
    
    @IBAction func logoutUser(_ sender: UIButton) {
        loadAlert()
    }
    
    @IBAction func saveSetting(_ sender: UIButton) {
        if(isEditProfile)
        {
            //        documentController.uploadProfile(name: nameField.text!, email: emailField.text!, genre: genreField.text!, myImage: settingImage.image!)
            //        uploadController.uploadPhoto(email: emailField.text!, myImage: settingImage.image!)
            let data:UserDataStruct = DataManager.shared().currentUser!
            data.name = nameField.text
            data.genre = selectedGenre
            data.profilePicture = settingImage.image
            data.phoneNumber = phoneNumberField.text
            data.instagram = instagramField.text
            
            let dataRec:CKRecord = DataManager.shared().currentUserRec!
            dataRec.setValuesForKeys(data.asDict())
            
            DataManager.shared().savecurrentUserRec()
            handleUnwind()
            
        }
        else
        {
            
            let data:UserDataStruct = UserDataStruct()
            data.name = nameField.text
            data.genre = selectedGenre
            data.profilePicture = settingImage.image
            data.phoneNumber = phoneNumberField.text
            data.instagram = instagramField.text
            
            // first time registering
            DataManager.shared().registerToCloudKit(email: emailAddr,
                                                    password: password,
                                                    userData: data)
            { (isSuccess, errorString, record) in
                if(isSuccess)
                {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "userProfileSegue", sender: nil)
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        print("ErrorString :\(errorString)")
                        let alert:UIAlertController = AlertViewHelper.createAlertView(type: .Error,
                                                        rightHandler: nil,
                                                        leftHandler: nil,
                                                        replacementString: [strKeyErrorMSG : errorString]
                        )
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
            
        }
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    func loadAlert() {
        //    let alertTitle = NSLocalizedString("Welcome", comment: "")
        let alertTitle = "Tiana Rosser"
        let alertMessage = NSLocalizedString("Are you sure want to sign out?", comment: "")
        let cancelButtonText = NSLocalizedString("Cancel", comment: "")
        let signupButtonText = NSLocalizedString("Sign Out", comment: "")
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: cancelButtonText, style: UIAlertAction.Style.cancel, handler: nil)
        let signupAction = UIAlertAction(title: signupButtonText, style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction) in
            self.userDefault.removeObject(forKey: "email")
            self.performSegue(withIdentifier: "logoutUser", sender: self)
        })
        alert.addAction(cancelAction)
        alert.addAction(signupAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// Extension to make more structured
extension SettingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Func to open camera and library function
    func openCameraAndLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionAlert = UIAlertController(title: NSLocalizedString("Browse attachment".uppercased(), comment: ""), message: "Choose source", preferredStyle: .alert)
        actionAlert.addAction(UIAlertAction(title: NSLocalizedString("Camera".uppercased(), comment: ""), style: .default, handler: {
            (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated:true, completion: nil)
            }else{
                print("Camera is not available at this device")
            }
        })) // give an option in alert controller to open camera
        
        actionAlert.addAction(UIAlertAction(title: NSLocalizedString("Photo library".uppercased(), comment: ""), style: .default, handler: { (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            self.present(imagePicker, animated:true, completion: nil)
        })) // give the second option in alert controller to open Photo library
        
        actionAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)) // give the third option in alert controller to cancel the form
        
        self.present(actionAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //        let videoURL = info[UIImagePickerController.InfoKey.phAsset] as? URL
        //        print(videoURL)
        if let imageTaken = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true) {
                self.settingImage?.image = imageTaken
            }
        }
    }
}

extension SettingController:UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}

extension SettingController:UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        musicGenreArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        musicGenreArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGenre = musicGenreArray[row]
        genreField?.text = selectedGenre
    }
    
}

extension SettingController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
           return OverlayPresentationController(presentedViewController:presented, presenting:presenting)
    }
}
