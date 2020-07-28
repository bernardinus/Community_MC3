//
//  SecondViewController.swift
//  CommunityMC3
//
//  Created by Bryanza on 06/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum ButtonType:Int{
    case All = 0
    case Artist = 1
    case Music = 2
    case Video = 3
    case Playlist = 4
}

class SearchView: UIViewController {
    
    @IBOutlet weak var mainSearchTableView: UITableView!
    //    @IBOutlet weak var allSearchButton: UIButton!
    //    @IBOutlet weak var artistSearchButton: UIButton!
    //    @IBOutlet weak var musicSearchButton: UIButton!
    //    @IBOutlet weak var videoSearchButton: UIButton!
    //    @IBOutlet weak var playlistSearchButton: UIButton!
    
    @IBOutlet var searchCategoryButton: [UIButton]!
    
    
    var vcSearch:SearchContainerPageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchContainer"
        {
            vcSearch = (segue.destination as! SearchContainerPageVC)
        }
    }
    
    func getSelectedActionType() -> ButtonType{
        for (index, button) in searchCategoryButton.enumerated() {
            if button.backgroundColor == #colorLiteral(red: 0.3450980392, green: 0.2, blue: 0.8392156863, alpha: 1) {
                vcSearch?.moveToPageSearch(index: index)
            }
        }
        return .All
    }
    
    @IBAction func searchTabSelected(_ sender: UIButton) {
        //Setup the active-inactive button color
        searchCategoryButton.forEach({
            $0.backgroundColor = .none
            $0.setTitleColor(#colorLiteral(red: 0.4117647059, green: 0.4745098039, blue: 0.9725490196, alpha: 1), for: .normal)
        })
        sender.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.2, blue: 0.8392156863, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        
        let activityType: ButtonType = getSelectedActionType()
    }
    
    //        switch sender {
    //        case allSearchButton:
    //            vcSearch?.moveToPageSearch(index: 0)
    //            sender.backgroundColor = .blue
    //        case artistSearchButton:
    //            vcSearch?.moveToPageSearch(index: 1)
    //            sender.backgroundColor = .blue
    //
    //        case musicSearchButton:
    //            vcSearch?.moveToPageSearch(index: 2)
    //            sender.backgroundColor = .blue
    //
    //        case videoSearchButton:        vcSearch?.moveToPageSearch(index: 3)
    //            sender.backgroundColor = .blue
    //
    //        case playlistSearchButton:
    //            vcSearch?.moveToPageSearch(index: 4)
    //            sender.backgroundColor = .blue
    //
    //        default:
    //            sender.backgroundColor = .none
    //            print("unknown button")
    //            return
    //        }
}
