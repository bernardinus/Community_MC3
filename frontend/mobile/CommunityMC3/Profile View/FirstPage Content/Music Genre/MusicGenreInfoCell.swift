//
//  MusicGenreCell.swift
//  CommunityMC3
//
//  Created by Theofani on 29/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MusicGenreInfoCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var musicGenreArray = ["Rock","Jazz","Pop","RnB","Acoustic","Blues"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MusicGenreCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! MusicGenreCell
        
        cell.musicGenreLabel.text = musicGenreArray[indexPath.row]
        setupUIViewForGenre(view: cell, genre: musicGenreArray[indexPath.row])
        
        return cell
    }
    
}
