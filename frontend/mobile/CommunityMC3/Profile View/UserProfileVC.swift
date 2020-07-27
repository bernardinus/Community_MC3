//
//  UserProfileVC.swift
//  CommunityMC3
//
//  Created by Theofani on 24/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    var userData:UserDataStruct?
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var actionSheet:UIAlertController = UIAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionSheet()
        // Do any additional setup after loading the view.
    }
    
    func setupActionSheet()
    {
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UserProfileVC : UIActionSheetDelegate
{
    
}

public extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}
