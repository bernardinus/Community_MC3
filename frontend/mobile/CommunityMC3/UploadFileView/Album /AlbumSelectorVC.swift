//
//  AlbumSelectorVC.swift
//  CommunityMC3
//
//  Created by Bernardinus on 29/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import CloudKit

class AlbumSelectorVC: UIViewController {

    var albumArr:[CKRecord]? = []
    
    @IBOutlet weak var availableAlbumTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        titleLabel.text = "Album"
        availableAlbumTable.register(albumListTableViewCell.nib(), forCellReuseIdentifier: albumListTableViewCell.identifier)
    }
    
    func UpdateAlbum()
    {
        
    }

}

extension AlbumSelectorVC:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArr!.count+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        87
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: albumListTableViewCell.identifier, for : indexPath) as! albumListTableViewCell
        //            customCell.configure(with: "Album title", imageName: "no_album")
        
        if(indexPath.row > 0)
        {
            
        }
        
        return customCell

    }
    
    
}
