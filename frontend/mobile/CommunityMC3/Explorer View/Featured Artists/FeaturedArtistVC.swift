//
//  FeaturedArtistVC.swift
//  CommunityMC3
//
//  Created by Theofani on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class FeaturedArtistVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var featuredArtistCollectionView: UICollectionView!
    var features: FeaturedDataStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.featuredArtistCollectionView.register(UINib.init(nibName: "FeaturedArtistCollectionCell", bundle: nil), forCellWithReuseIdentifier: "artistCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 180)
        featuredArtistCollectionView.collectionViewLayout = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if features != nil {
            return features!.users.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = featuredArtistCollectionView.dequeueReusableCell(withReuseIdentifier: "artistCollectionViewCell", for: indexPath as IndexPath) as! FeaturedArtistCollectionCell
        cell.updateData(userData: features!.users[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "artistPageSegue", sender: nil)
    }
}
