//
//  SelectFileView.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SelectFileView: UIViewController
{

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var selectFileTitleLabel: UILabel!
    
    var fileList:[URL] = []
    
    var filteredList:[URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SelectViewCell", bundle:nil), forCellReuseIdentifier: "selectViewCell")
        
        fileList = FileManagers.getAvailableAudioFiles()
        filteredList = fileList
        
        selectFileTitleLabel.text = NSLocalizedString("Select File", comment: "")
        
    }
    
    @IBAction func cancelButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func filter(filterText:String)
    {
        print("asd+\(filterText)+asd")
        if(filterText.isEmpty || filterText == "")
        {
            filteredList = fileList
        }
        else
        {
            filteredList = fileList.filter{$0.lastPathComponent.lowercased().contains(filterText.lowercased())}
        }
        tableView.reloadData()
    }
    
}


extension SelectFileView:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filter(filterText: searchText)
    }
}

extension SelectFileView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectViewCell") as! SelectViewCell
        cell.fileName.text = filteredList[indexPath.row].lastPathComponent
        print("\(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "uploadFileSegue", sender:nil)
    }
}
