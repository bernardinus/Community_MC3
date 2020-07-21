//
//  FeaturedArtistCell.swift
//  CommunityMC3
//
//  Created by Theofani on 21/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FeaturedArtistCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var featuredArtistsCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.featuredArtistsCollectionView.dataSource = self
        self.featuredArtistsCollectionView.delegate = self
        self.featuredArtistsCollectionView.register(UINib.init(nibName: "FeaturedArtistCollectionCell", bundle: nil), forCellWithReuseIdentifier: "artistCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredArtistsCollectionView.dequeueReusableCell(withReuseIdentifier: "artistCollectionViewCell", for: indexPath as IndexPath) as! FeaturedArtistCollectionCell
        
        return cell
    }
    
    
}
