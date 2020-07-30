//
//  FavoriteArtistsView.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 29/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FavoriteArtistsView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "FavoriteArtistsCell", bundle: nil), forCellWithReuseIdentifier: "favoriteArtistsCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension FavoriteArtistsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteArtistsCell", for: indexPath) as! FavoriteArtistsCell
        
        cell.artistImage.image = #imageLiteral(resourceName: "artist-4")
        
        return cell
    }
    
    
}
