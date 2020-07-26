//
//  SettingController.swift
//  CommunityMC3
//
//  Created by Bryanza on 16/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

//import Foundation
import UIKit

class SettingController: UIViewController {
    
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    
//    let documentController = DocumentTableViewController.shared
    let uploadController = UploadController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uploadTap = UITapGestureRecognizer(target: self, action: #selector(self.handleUploadTap(_:)))
        settingImage.addGestureRecognizer(uploadTap)
        let userDefault = UserDefaults.standard
        if let loadEmail = userDefault.string(forKey: "email"){
            emailField.text = loadEmail
        }
//        documentController.getProfilesFromCloudKit { (profiles) in
//            for profile in profiles {
//                print(profile.name, profile.email, profile.genre)
//            }
//        }
        uploadController.getPhotosFromCloudKit { (photos) in
            for photo in photos {
                if photo.email == "mnb@mnb" {
                    if let data = NSData(contentsOf: photo.fileURL) {
                        DispatchQueue.main.async {
                            self.settingImage.image = UIImage(data: data as Data)
                        }
                   }
                }
            }
        }
    }
    
    @objc func handleUploadTap(_ sender: UITapGestureRecognizer? = nil) {
        self.openCameraAndLibrary()
    }
    
    @IBAction func logoutUser(_ sender: UIButton) {
        loadAlert()
    }
    
    @IBAction func saveSetting(_ sender: UIButton) {
//        documentController.uploadProfile(name: nameField.text!, email: emailField.text!, genre: genreField.text!, myImage: settingImage.image!)
        uploadController.uploadPhoto(email: emailField.text!, myImage: settingImage.image!)
    }
    
    func loadAlert() {
    //    let alertTitle = NSLocalizedString("Welcome", comment: "")
        let alertTitle = "Tiana Rosser"
        let alertMessage = NSLocalizedString("Are you sure want to sign out?", comment: "")
        let cancelButtonText = NSLocalizedString("Cancel", comment: "")
        let signupButtonText = NSLocalizedString("Sign Out", comment: "")

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: cancelButtonText, style: UIAlertAction.Style.cancel, handler: nil)
        let signupAction = UIAlertAction(title: signupButtonText, style: UIAlertAction.Style.default, handler: nil)
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
        let actionAlert = UIAlertController(title: "Browse attachment", message: "Choose source", preferredStyle: .alert)
        actionAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated:true, completion: nil)
            }else{
                print("Camera is not available at this device")
            }
        })) // give an option in alert controller to open camera
        
        actionAlert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            self.present(imagePicker, animated:true, completion: nil)
        })) // give the second option in alert controller to open Photo library
        
        actionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) // give the third option in alert controller to cancel the form
        
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
