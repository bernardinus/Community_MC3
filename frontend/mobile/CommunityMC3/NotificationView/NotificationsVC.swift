//
//  NotificationsVC.swift
//  CommunityMC3
//
//  Created by Theofani on 21/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backItem?.title = ""

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super .viewWillAppear(animated)
    }

    @IBAction func clearAllButtonTouched(_ sender: Any)
    {
        
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
