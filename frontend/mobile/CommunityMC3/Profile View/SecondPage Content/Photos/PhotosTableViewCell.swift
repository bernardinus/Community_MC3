//
//  PhotosTableViewCell.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photosCollectionCell: UICollectionView!
    
    var photosData:[PhotoDataStruct]? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photosCollectionCell.dataSource = self
        self.photosCollectionCell.delegate = self
        self.photosCollectionCell.register(UINib.init(nibName: "PhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "photosCollectionCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateData(photosData:[PhotoDataStruct])
    {
        self.photosData = photosData
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionCell.dequeueReusableCell(withReuseIdentifier: "photosCollectionCell", for: indexPath as IndexPath) as! PhotosCollectionCell
//        cell.photosCollectionImage.image = photosData![indexPath.row].photosData!
        return cell
    }
    
    
}
