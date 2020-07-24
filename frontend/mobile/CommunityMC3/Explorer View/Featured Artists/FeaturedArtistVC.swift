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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.featuredArtistCollectionView.register(UINib.init(nibName: "FeaturedArtistCollectionCell", bundle: nil), forCellWithReuseIdentifier: "artistCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 180)
        featuredArtistCollectionView.collectionViewLayout = layout

    }
       
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super .viewWillDisappear(animated)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 12
       }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = featuredArtistCollectionView.dequeueReusableCell(withReuseIdentifier: "artistCollectionViewCell", for: indexPath as IndexPath) as! FeaturedArtistCollectionCell
           
           return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
}
