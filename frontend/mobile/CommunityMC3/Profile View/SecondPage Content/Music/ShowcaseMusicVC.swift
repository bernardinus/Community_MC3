//
//  ShowcaseMusicVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ShowcaseMusicVC: UIViewController {
    
    @IBOutlet weak var showcaseMusicTable: UITableView!
    var tracksData:[TrackDataStruct]?=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showcaseMusicTable.register(UINib(nibName: "MusicTableViewCell", bundle:nil), forCellReuseIdentifier: "musicTableCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trackPlayerSegue"
        {
            if let vc = segue.destination as? TrackPlayerViewController
            {
                vc.track = sender as? TrackDataStruct
            }
        }
    }
}

extension ShowcaseMusicVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracksData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showcaseMusicTable.dequeueReusableCell(withIdentifier: "musicTableCell") as! MusicTableViewCell
        cell.updateData(track: tracksData![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "trackPlayerSegue", sender: tracksData![indexPath.row])
    }
    
}
