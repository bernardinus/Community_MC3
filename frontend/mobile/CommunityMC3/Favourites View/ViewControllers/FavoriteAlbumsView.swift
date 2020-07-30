//
//  FavoriteAlbumsView.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 29/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FavoriteAlbumsView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "FavoriteAlbumsCell", bundle: nil), forCellWithReuseIdentifier: "favoriteAlbumsCell")
    }
    
}

extension FavoriteAlbumsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteAlbumsCell", for: indexPath) as! FavoriteAlbumsCell
        cell.albumCoverImage.layer.cornerRadius = 4
        cell.albumCoverImage.image = #imageLiteral(resourceName: "photos-dummy")
        
        return cell
    }
    
}
