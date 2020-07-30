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
    
    var isUploadVideo:Bool = false
    
    let documentController = DocumentTableViewController.shared
    
    var fileList:[URL] = []
    
    var filteredList:[URL] = []
    var selectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SelectViewCell", bundle:nil), forCellReuseIdentifier: "selectViewCell")
        
        
        
        if(isUploadVideo)
        {
            fileList = FileManagers.getAvailableVideoFiles()
        }
        else
        {
            fileList = FileManagers.getAvailableAudioFiles()
        }
        
        
        
        filteredList = fileList
        
        selectFileTitleLabel.text = NSLocalizedString("Select File", comment: "")
        
    }
    
    @IBAction func cancelButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uploadFileSegue"
        {
            let uploadFileVC = segue.destination as! UploadFileView
            uploadFileVC.isUploadVideo = isUploadVideo
            uploadFileVC.fileURL = filteredList[selectedIndex]
        }
     }
    
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
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "uploadFileSegue", sender:nil)
        //        documentController.uploadTrack(email: "mnb@mnb", genre: "Rock", name: "track", fileURL: filteredList[indexPath.row])
        //        performSegue(withIdentifier: "uploadTest", sender:nil)
    }
}
