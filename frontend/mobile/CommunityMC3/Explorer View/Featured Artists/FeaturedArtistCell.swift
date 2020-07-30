//
//  FeaturedArtistCell.swift
//  CommunityMC3
//
//  Created by Theofani on 21/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FeaturedArtistCell: UITableViewCell
{
    
    @IBOutlet weak var featuredArtistsCollectionCell: UICollectionView!    
    var callBack: (() -> Void)? = nil
    
    var features: [FeaturedDataStruct]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.featuredArtistsCollectionCell.dataSource = self
        self.featuredArtistsCollectionCell.delegate = self
        self.featuredArtistsCollectionCell.register(UINib.init(nibName: "FeaturedArtistCollectionCell", bundle: nil), forCellWithReuseIdentifier: "artistCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension FeaturedArtistCell : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if features != nil {
            return features.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredArtistsCollectionCell.dequeueReusableCell(withReuseIdentifier: "artistCollectionViewCell", for: indexPath as IndexPath) as! FeaturedArtistCollectionCell
        if let data = NSData(contentsOf: features[indexPath.row].user!.fileURL!) {
            DispatchQueue.main.async {
                cell.artistImageView.image = UIImage(data: data as Data)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callBack!()
    }
}
