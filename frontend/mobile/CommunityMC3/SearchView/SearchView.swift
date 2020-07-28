//
//  SecondViewController.swift
//  CommunityMC3
//
//  Created by Bryanza on 06/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SearchView: UIViewController {

    @IBOutlet weak var mainSearchTableView: UITableView!
    @IBOutlet weak var allSearchButton: UIButton!
    @IBOutlet weak var artistSearchButton: UIButton!
    @IBOutlet weak var musicSearchButton: UIButton!
    @IBOutlet weak var videoSearchButton: UIButton!
    @IBOutlet weak var playlistSearchButton: UIButton!
    
    var vc:SearchContainerPageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchContainer"
        {
            vc = (segue.destination as! SearchContainerPageVC)
        }
    }

    @IBAction func tapAllSearch(_ sender: Any) {
        vc?.moveToPage(index: 0)
    }
    
    @IBAction func tapArtistSearch(_ sender: Any) {
        vc?.moveToPage(index: 1)
    }
    
    @IBAction func tapMusicSearch(_ sender: Any) {
        vc?.moveToPage(index: 2)
    }
    
    @IBAction func tapVideoSearch(_ sender: Any) {
        vc?.moveToPage(index: 3)
    }
    
    @IBAction func tapPlaylistSearch(_ sender: Any) {
        vc?.moveToPage(index: 4)
    }
    
}

