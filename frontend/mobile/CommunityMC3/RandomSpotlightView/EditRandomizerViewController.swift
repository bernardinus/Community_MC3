//
//  EditRandomizerViewController.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class EditRandomizerViewController: UIViewController {

    @IBOutlet weak var sortByCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var applyButton: UIButton!
    
    var sortByArray = ["Music", "Artist"]
    var genreArray = ["Rock", "Jazz", "Pop", "RnB", "Acoutic", "Blues"]
    
    var sortByTemp = 0
    var genreTemp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        sortByCollectionView.register(UINib(nibName: "SortByCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sortBy")
        genreCollectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
        
        applyButton.layer.cornerRadius = 5
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func clearAllButtonAction(_ sender: UIButton) {
        
    }
    
    
}

extension EditRandomizerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sortByCollectionView{
            return sortByArray.count
        }else{
            return genreArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sortByCollectionView {
            let cell = sortByCollectionView.dequeueReusableCell(withReuseIdentifier: "sortBy", for: indexPath) as! SortByCollectionViewCell
            cell.sortByLabel.text = sortByArray[indexPath.row]
            cell.checkBoxImage.layer.borderColor = UIColor.lightGray.cgColor
            cell.checkBoxImage.layer.borderWidth = 1
            cell.checkBoxImage.layer.cornerRadius = 6
        
            return cell
        }else {
            let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCollectionViewCell
            cell.genreLabel.text = genreArray[indexPath.row]
            cell.genreCheckBoxImage.layer.borderColor = UIColor.lightGray.cgColor
            cell.genreCheckBoxImage.layer.masksToBounds = true
            cell.genreCheckBoxImage.layer.borderWidth = 1
            cell.genreCheckBoxImage.layer.cornerRadius = 6
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sortByCollectionView{
            let cell = sortByCollectionView.cellForItem(at: indexPath) as! SortByCollectionViewCell
            self.sortByTemp = indexPath.row
            cell.checkBoxImage.image = #imageLiteral(resourceName: "checkBox")
            cell.checkBoxImage.layer.borderWidth = 0
        }else{
            let cell = genreCollectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
            self.genreTemp = indexPath.row
            cell.genreCheckBoxImage.image = #imageLiteral(resourceName: "checkBox")
            cell.genreCheckBoxImage.layer.borderWidth = 0
        }
    }
    
    
}
