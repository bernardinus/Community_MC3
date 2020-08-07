//
//  ArtistSearchVC.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ArtistSearchVC: UIViewController {
    
    @IBOutlet weak var artistSeachTableView: UITableView!
    
    var dm:DataManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistSeachTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        artistSeachTableView.register(UINib(nibName: "ArtistSearchCell", bundle: nil), forCellReuseIdentifier: "artistSearchCell")
        
        dm = DataManager.shared()
    }
}

extension ArtistSearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dm!.filteredArtist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = artistSeachTableView.dequeueReusableCell(withIdentifier: "artistSearchCell") as! ArtistSearchCell
        cell.updateData(dm!.filteredArtist[indexPath.row])
        return cell
    }
    
    
    
}
