//
//  UploadPanelViewController.swift
//  Allegro
//
//  Created by Rommy Julius Dwidharma on 04/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class UploadPanelViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var optionList = ["Audio", "Photo","Video"]
    var iconList = ["audioIcon", "imageIcon", "videoIcon"]
    var imgPicker:ImagePicker?
    var isUploadVideo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView(){
        tableView.register(UINib(nibName: "UploadPanelCell", bundle: nil), forCellReuseIdentifier: "uploadPanelCell")
        imgPicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        let userProfileVC = UserProfileVC()
        userProfileVC.overlayView.removeFromSuperview()
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectFileSegue"
        {
            let selectVC = segue.destination as! SelectFileView
            selectVC.isUploadVideo = isUploadVideo
        }
    }
}

extension UploadPanelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "uploadPanelCell", for: indexPath) as! UploadPanelCell
        cell.panelLabel.text = optionList[indexPath.row]
        cell.panelIconImage.image = UIImage(imageLiteralResourceName: iconList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.isUploadVideo = false
            self.performSegue(withIdentifier: "selectFileSegue", sender: nil)
        }else if indexPath.row == 1{
            self.imgPicker?.present(from: self.view)
        }else if indexPath.row == 2{
            self.isUploadVideo = true
            performSegue(withIdentifier: "selectFileSegue", sender: nil)
        }
    }

}
extension UploadPanelViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?)
    {
//        coverImage?.image = image
        var photoData = PhotoDataStruct()
        photoData.email = DataManager.shared().currentUser?.email!
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
