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
    
    var indexTemp = 0
    var sortByTemp = [Int]()
    var genreTemp = [Int]()
    var selectedIndexSortByBool: [IndexPath: Bool] = [:]
    var selectedIndexGenreBool: [IndexPath: Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        sortByCollectionView.register(UINib(nibName: "SortByCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sortBy")
        genreCollectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
        sortByCollectionView.allowsMultipleSelection = true
        genreCollectionView.allowsMultipleSelection = true
        
        applyButton.layer.cornerRadius = 5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? RandomSpotlightViewController {
            for i in sortByTemp{
                destinationSegue.musicFilter.append(sortByArray[i])
            }
            for i in genreTemp{
                destinationSegue.genreFilter.append(genreArray[i])
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func clearAllButtonAction(_ sender: UIButton) {
        let selectedIndexSortBy = sortByCollectionView.indexPathsForSelectedItems
        let selectedGenre = genreCollectionView.indexPathsForSelectedItems
        
        for indexPath in selectedIndexSortBy! {
            let cell = sortByCollectionView.cellForItem(at: indexPath) as! SortByCollectionViewCell
            sortByCollectionView.deselectItem(at: indexPath, animated: true)
            cell.checkBoxImage.image = nil
            cell.checkBoxImage.layer.borderWidth = 1
            sortByTemp.removeAll()
            print(sortByTemp)
        }
        
        for indexPath in selectedGenre! {
            let cell = genreCollectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
            genreCollectionView.deselectItem(at: indexPath, animated: true)
            cell.genreCheckBoxImage.image = nil
            cell.genreCheckBoxImage.layer.borderWidth = 1
            genreTemp.removeAll()
        }
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
            if sortByTemp.contains(indexPath.row){
                let cell = sortByCollectionView.cellForItem(at: indexPath) as! SortByCollectionViewCell
                self.sortByTemp.remove(at: self.sortByTemp.firstIndex(of: indexPath.row)!)
                cell.checkBoxImage.image = nil
                cell.checkBoxImage.layer.borderWidth = 1
            } else {
                let cell = sortByCollectionView.cellForItem(at: indexPath) as! SortByCollectionViewCell
                self.sortByTemp.append(indexPath.row)
                cell.checkBoxImage.image = #imageLiteral(resourceName: "checkBox")
                cell.checkBoxImage.layer.borderWidth = 0
            }
            print(sortByTemp)
          
        }else{
            if genreTemp.contains(indexPath.row){
                let cell = genreCollectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
                self.genreTemp.remove(at: self.genreTemp.firstIndex(of: indexPath.row)!)
                cell.genreCheckBoxImage.image = nil
                cell.genreCheckBoxImage.layer.borderWidth = 1
            }else{
                let cell = genreCollectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
                self.genreTemp.append(indexPath.row)
                cell.genreCheckBoxImage.image = #imageLiteral(resourceName: "checkBox")
                cell.genreCheckBoxImage.layer.borderWidth = 0
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == sortByCollectionView{
            selectedIndexSortByBool[indexPath] = false
        }else{
            selectedIndexGenreBool[indexPath] = false
        }
    }
}
