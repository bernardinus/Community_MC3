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
    
    var artistData:[UserDataStruct]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "FavoriteArtistsCell", bundle: nil), forCellWithReuseIdentifier: "favoriteArtistsCell")
        artistData = DataManager.shared().favArtistData
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
    }
    

}

extension FavoriteArtistsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if artistData != nil
        {
            return artistData!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteArtistsCell", for: indexPath) as! FavoriteArtistsCell
        cell.updateData(data: artistData![indexPath.row])
        cell.artistImage.image = #imageLiteral(resourceName: "artist-4")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "artistProfileSegue", sender: nil)
    }
    
}
