//
//  GenreProfileController.swift
//  Allegro
//
//  Created by Bryanza on 05/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class GenreProfileController: UIViewController {
    
    var genreArray = ["Rock", "Jazz", "Pop", "RnB", "Acoutic", "Blues"]
    var genreTemp = [Int]()
    var selectedIndexGenreBool: [IndexPath: Bool] = [:]
    @IBOutlet weak var genreProfile: UICollectionView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var editGenreLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalisation()
        setup()
    }
    
    func loadLocalisation() {
        editGenreLabel.text = NSLocalizedString("Edit genre".uppercased(), comment: "")
        clearAllButton.titleLabel?.text = NSLocalizedString("Clear All".uppercased(), comment: "")
        applyButton.titleLabel?.text = NSLocalizedString("Apply".uppercased(), comment: "")
        cancelButton.titleLabel?.text = NSLocalizedString("Cancel", comment: "")
    }
    
    func setup(){
        genreProfile.register(UINib(nibName: "GenreProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "genreProfile")
        genreProfile.allowsMultipleSelection = true
        
        applyButton.layer.cornerRadius = 5
    }
    
    @IBAction func cancelGenreProfile(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearAllGenreProfile(_ sender: UIButton) {
        let selectedGenre = genreProfile.indexPathsForSelectedItems
        
        for indexPath in selectedGenre! {
            let cell = genreProfile.cellForItem(at: indexPath) as! GenreProfileCollectionViewCell
            genreProfile.deselectItem(at: indexPath, animated: true)
            cell.genreProfileCheckbox.image = nil
            cell.genreProfileCheckbox.layer.borderWidth = 1
            genreTemp.removeAll()
        }
    }
    
    
    @IBAction func saveGenreProfile(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
}

extension GenreProfileController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreProfile.dequeueReusableCell(withReuseIdentifier: "genreProfile", for: indexPath) as! GenreProfileCollectionViewCell
        cell.genreProfileLabel.text = genreArray[indexPath.row]
        cell.genreProfileCheckbox.layer.borderColor = UIColor.lightGray.cgColor
        cell.genreProfileCheckbox.layer.masksToBounds = true
        cell.genreProfileCheckbox.layer.borderWidth = 1
        cell.genreProfileCheckbox.layer.cornerRadius = 6
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if genreTemp.contains(indexPath.row){
            let cell = genreProfile.cellForItem(at: indexPath) as! GenreProfileCollectionViewCell
            self.genreTemp.remove(at: self.genreTemp.firstIndex(of: indexPath.row)!)
            cell.genreProfileCheckbox.image = nil
            cell.genreProfileCheckbox.layer.borderWidth = 1
        }else{
            let cell = genreProfile.cellForItem(at: indexPath) as! GenreProfileCollectionViewCell
            self.genreTemp.append(indexPath.row)
            cell.genreProfileCheckbox.image = #imageLiteral(resourceName: "checkBox")
            cell.genreProfileCheckbox.layer.borderWidth = 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedIndexGenreBool[indexPath] = false
    }
}
