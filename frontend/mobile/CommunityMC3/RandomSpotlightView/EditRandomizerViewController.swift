//
//  EditRandomizerViewController.swift
//  Allegro
//
//  Created by Rommy Julius Dwidharma on 05/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//
import UIKit

enum EditRandomizer: Int {
    case SortBy = 0
    case Genre = 1
    case Count = 2
}

class EditRandomizerViewController: UIViewController {
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var editRandomizerLabel: UILabel!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var sortByTableView: UITableView!
    @IBOutlet weak var genreTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var callback:((Bool)->Void)? = nil
    
    var sortByArray = ["Music", "Artist"]
    
    var indexTemp = 0
    var sortByTemp = [Int]()
    var genreTemp = [Int]()
    var selectedIndexSortByBool: [IndexPath: Bool] = [:]
    var selectedIndexGenreBool: [IndexPath: Bool] = [:]
    let randomSpotlight = RandomSpotlightViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocalisation()
        setup()
        
    }
    
    func loadLocalisation() {
        editRandomizerLabel.text = NSLocalizedString("Edit randomizer".uppercased(), comment: "")
        clearAllButton.titleLabel?.text = NSLocalizedString("Clear All".uppercased(), comment: "")
        applyButton.titleLabel?.text = NSLocalizedString("Apply".uppercased(), comment: "")
        cancelButton.titleLabel?.text = NSLocalizedString("Cancel", comment: "")
    }
    
    func setup(){
        tableView.register(UINib(nibName: "HeaderCellRandomSpotlight", bundle: nil), forCellReuseIdentifier: "headerCellRandom")
        tableView.register(UINib(nibName: "EditRandomizerContextCell", bundle: nil), forCellReuseIdentifier: "editRandomizerContextCell")
        tableView.allowsMultipleSelection = true
        applyButton.layer.cornerRadius = 5
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationSegue = segue.destination as? RandomSpotlightViewController
//            for i in sortByTemp{
//                destinationSegue!.musicFilter.append(sortByArray[i])
//            }
//            for i in genreTemp{
//                destinationSegue!.genreFilter.append(genreArray[i])
//            }
//    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
       
        
    }
    
    @IBAction func applyButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        callback!(false)
    }
    
    @IBAction func clearAllButtonAction(_ sender: UIButton) {
        let selectedIndex = tableView.indexPathsForSelectedRows
        
        for i in selectedIndex! {
            tableView.deselectRow(at: i, animated: true)
            tableView.cellForRow(at: i)?.accessoryType = UITableViewCell.AccessoryType.none
            
            genreTemp.removeAll()
            sortByTemp.removeAll()
        }
    }
    
    
    
}

extension EditRandomizerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == EditRandomizer.SortBy.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCellRandom") as! HeaderCellRandomSpotlight
            cell.headerTitle.text = "Sort by".uppercased()
            cell.headerTitle.textColor = UIColor.black
            return cell
        }else if section == EditRandomizer.Genre.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCellRandom") as! HeaderCellRandomSpotlight
            cell.headerTitle.text = "Genre".uppercased()
            cell.headerTitle.textColor = UIColor.black
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "headerCellRandom")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EditRandomizer.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == EditRandomizer.SortBy.rawValue {
            return sortByArray.count
        }else if section == EditRandomizer.Genre.rawValue{
            return musicGenreArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == EditRandomizer.SortBy.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "editRandomizerContextCell", for: indexPath) as! EditRandomizerContextCell
            cell.contextLabel.text = sortByArray[indexPath.row]
            return cell
        }else if indexPath.section == EditRandomizer.Genre.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "editRandomizerContextCell", for: indexPath) as! EditRandomizerContextCell
            cell.contextLabel.text = musicGenreArray[indexPath.row]
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "editRandomizerContextCell")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == EditRandomizer.SortBy.rawValue{

            if sortByTemp.contains(indexPath.row){
                print("music remove")
                self.sortByTemp.remove(at: self.sortByTemp.firstIndex(of: indexPath.row)!)
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }else{
                print("music add")
                self.sortByTemp.append(indexPath.row)
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
            print("music \(sortByTemp)")
        }else if indexPath.section == EditRandomizer.Genre.rawValue{
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
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == EditRandomizer.SortBy.rawValue{
            
            if sortByTemp.contains(indexPath.row){
                print("music remove")
                self.sortByTemp.remove(at: self.sortByTemp.firstIndex(of: indexPath.row)!)
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }else{
                print("music add")
                self.sortByTemp.append(indexPath.row)
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
            print("music \(sortByTemp)")
        }else if indexPath.section == EditRandomizer.Genre.rawValue{
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
    
}

