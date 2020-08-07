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
    
    @IBOutlet weak var genreProfile: UITableView!
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
//        genreProfile.register(UINib(nibName: "GenreProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "genreProfile")
        genreProfile.register(UINib(nibName: "GenreProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "genreProfileContextCell")
        genreProfile.allowsMultipleSelection = true
        
        applyButton.layer.cornerRadius = 5
    }
    
    @IBAction func cancelGenreProfile(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearAllGenreProfile(_ sender: UIButton) {
//        let selectedGenre = genreProfile.indexPathsForSelectedRows
//
//        for indexPath in selectedGenre! {
//            let cell = genreProfile.cellForItem(at: indexPath) as! GenreProfileCollectionViewCell
//            genreProfile.deselectItem(at: indexPath, animated: true)
//            cell.genreProfileCheckbox.image = nil
//            cell.genreProfileCheckbox.layer.borderWidth = 1
//            genreTemp.removeAll()
//        }
        let selectedIndex = genreProfile.indexPathsForSelectedRows
        
        for i in selectedIndex! {
            genreProfile.deselectRow(at: i, animated: true)
            genreProfile.cellForRow(at: i)?.accessoryType = UITableViewCell.AccessoryType.none
            
            genreTemp.removeAll()
        }
    }
    
    
    @IBAction func saveGenreProfile(_ sender: UIButton) {
        var temp = ""
        var idx = 0
        for genre in genreArray {
            if genreTemp.contains(idx) {
                temp += genre + ","
            }
            idx += 1
        }
        if let presenter = presentingViewController as? SettingController {
            presenter.genreField.text = String(temp.dropLast())
        }
        dismiss(animated: true, completion: nil)
    }
    
}

//extension GenreProfileController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return genreArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = genreProfile.dequeueReusableCell(withReuseIdentifier: "genreProfile", for: indexPath) as! GenreProfileCollectionViewCell
//        cell.genreProfileLabel.text = genreArray[indexPath.row]
//        cell.genreProfileCheckbox.layer.borderColor = UIColor.lightGray.cgColor
//        cell.genreProfileCheckbox.layer.masksToBounds = true
//        cell.genreProfileCheckbox.layer.borderWidth = 1
//        cell.genreProfileCheckbox.layer.cornerRadius = 6
//        
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if genreTemp.contains(indexPath.row){
//            let cell = genreProfile.cellForItem(at: indexPath) as! GenreProfileCollectionViewCell
//            self.genreTemp.remove(at: self.genreTemp.firstIndex(of: indexPath.row)!)
//            cell.genreProfileCheckbox.image = nil
//            cell.genreProfileCheckbox.layer.borderWidth = 1
//        }else{
//            let cell = genreProfile.cellForItem(at: indexPath) as! GenreProfileCollectionViewCell
//            self.genreTemp.append(indexPath.row)
//            cell.genreProfileCheckbox.image = #imageLiteral(resourceName: "checkBox")
//            cell.genreProfileCheckbox.layer.borderWidth = 0
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        selectedIndexGenreBool[indexPath] = false
//    }
//}

extension GenreProfileController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreProfileContextCell", for: indexPath) as! GenreProfileTableViewCell
        cell.genreProfileLabel.text = genreArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if genreTemp.contains(indexPath.row){
            print("genre remove")
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            self.genreTemp.remove(at: self.genreTemp.firstIndex(of: indexPath.row)!)
        }else{
            print("genre aadd")
            self.genreTemp.append(indexPath.row)
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        print("genre \(genreTemp)")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if genreTemp.contains(indexPath.row){
            print("genre remove")
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            self.genreTemp.remove(at: self.genreTemp.firstIndex(of: indexPath.row)!)
        }else{
            print("genre add")
            self.genreTemp.append(indexPath.row)
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        print("genre \(genreTemp)")
    }
    
}
