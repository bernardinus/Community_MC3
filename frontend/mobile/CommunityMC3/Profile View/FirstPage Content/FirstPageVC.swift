//
//  FirstPageVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FirstPageVC: UIViewController {

    @IBOutlet weak var aboutTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutTableView.register(UINib(nibName: "AboutHeaderCell", bundle: nil), forCellReuseIdentifier: "aboutHeaderCell")
        
    }
    

 

}
