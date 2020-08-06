//
//  SecondViewController.swift
//  CommunityMC3
//
//  Created by Bryanza on 06/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum ButtonType:Int{
    case All = 0
    case Artist = 1
    case Music = 2
    case Video = 3
    case Playlist = 4
}

class SearchView: UIViewController {
    
    @IBOutlet var searchCategoryButton: [UIButton]!
    
    var vcSearch:SearchContainerPageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchContainer"
        {
            vcSearch = (segue.destination as! SearchContainerPageVC)
        }
    }
    
    func getSelectedActionType() -> ButtonType{
        //Set each button action by index
        for (index, button) in searchCategoryButton.enumerated() {
            if button.backgroundColor == #colorLiteral(red: 0.3450980392, green: 0.2, blue: 0.8392156863, alpha: 1) {
                vcSearch?.moveToPageSearch(index: index)
            }
        }
        return .All
    }
    
    @IBAction func accountButtonTouched(_ sender: Any)
    {
        if DataManager.shared().IsUserLogin()
        {
            self.performSegue(withIdentifier: "userProfileSegue", sender: nil)
        }
        else
        {
            self.performSegue(withIdentifier: "loginScreenSegue", sender: nil)
        }
    }
    
    @IBAction func searchTabSelected(_ sender: UIButton) {
        //Setup the active-inactive button color
        searchCategoryButton.forEach({
            $0.backgroundColor = .none
            $0.setTitleColor(#colorLiteral(red: 0.4117647059, green: 0.4745098039, blue: 0.9725490196, alpha: 1), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        })
        sender.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.2, blue: 0.8392156863, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        sender.layer.cornerRadius = 15
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        //Assign each action button
        let _: ButtonType = getSelectedActionType()
    }
    
//    func filter(filterText:String)
//    {
//        print("asd+\(filterText)+asd")
//        if(filterText.isEmpty || filterText == "")
//        {
//            filteredList = fileList
//        }
//        else
//        {
//            filteredList = fileList.filter{$0.lastPathComponent.lowercased().contains(filterText.lowercased())}
//        }
//        tableView.reloadData()
//    }
}

extension SearchView:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
//        filter(filterText: searchText)
    }
}
