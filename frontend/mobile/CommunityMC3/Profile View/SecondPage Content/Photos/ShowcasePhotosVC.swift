//
//  ShowcasePhotosVC.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ShowcasePhotosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var showcasePhotosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showcasePhotosCollectionView.register(UINib.init(nibName: "PhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "photosCollectionCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        showcasePhotosCollectionView.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = showcasePhotosCollectionView.dequeueReusableCell(withReuseIdentifier: "photosCollectionCell", for: indexPath as IndexPath) as! PhotosCollectionCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
}
