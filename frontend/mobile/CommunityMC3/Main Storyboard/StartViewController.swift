//
//  StartViewController.swift
//  Allegro
//
//  Created by Rommy Julius Dwidharma on 06/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    
    @IBOutlet weak var baseContainerVC: UIView!
    @IBOutlet weak var miniPlayerVC: UIView!
    
    
//    var baseVC:UINavigationController? = nil
    var baseVC:UITabBarController? = nil
    
    var miniPlayerView:UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "baseSegue"
        {
            baseVC = segue.destination as? UITabBarController
            
        }
        else if segue.identifier == "miniPlayerSegue"
        {
            miniPlayerView = segue.destination
        }
    }

}
