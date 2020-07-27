//
//  SecondPageVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum ShowcaseSection:Int{
    case Music = 0
    case Photos = 1
    case Videos = 2
    case Count = 3
}

class SecondPageVC: UIViewController {

    @IBOutlet weak var showcaseTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showcaseTableView.register(UINib(nibName: "ShowcaseHeaderCell", bundle: nil), forCellReuseIdentifier:"showcaseHeaderCell")
        showcaseTableView.register(UINib(nibName: "ShowcaseHeaderCell", bundle: nil), forCellReuseIdentifier:"showcaseHeaderCell")
    }
    

}
