//
//  MainTabController.swift
//  CommunityMC3
//
//  Created by Bernardinus on 26/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let maxTabCount:Int = tabBar.items!.count
        print(maxTabCount)
        for index in 0..<maxTabCount
        {
            let item = tabBar.items![index]
            switch index {
            case 0: // ExplorerView
                item.title = NSLocalizedString("TAB_Explore",comment: "")
            case 1: // SearchView
                item.title = NSLocalizedString("TAB_Search",comment: "")
            case 2: // FavouritesView
                item.title = NSLocalizedString("TAB_Favourites",comment: "")
                
            default:
                print("Error should not go in this switch")
            }
        }
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
