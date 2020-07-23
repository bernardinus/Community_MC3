//
//  ViewController.swift
//  MC3 Table View Test
//
//  Created by Nur Minnuri Qalbi on 20/07/20.
//  Copyright © 2020 Nur Minnuri Qalbi. All rights reserved.
//

import UIKit

class UploadFileView: UIViewController
{
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        table.register(UploadTableViewCell.nib(), forCellReuseIdentifier: UploadTableViewCell.identifier)
        table.register(AddCoverTableViewCell.nib(), forCellReuseIdentifier: AddCoverTableViewCell.identifier)
        table.register(GenreTableViewCell.nib(), forCellReuseIdentifier: GenreTableViewCell.identifier)
        table.register(albumTitleTableViewCell.nib(), forCellReuseIdentifier: albumTitleTableViewCell.identifier)
        table.register(albumListTableViewCell.nib(), forCellReuseIdentifier: albumListTableViewCell.identifier)
        table.register(descTitleTableViewCell.nib(), forCellReuseIdentifier: descTitleTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        table.separatorColor = UIColor.clear
    }

    
}

extension UploadFileView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 5
            {
                
                return 91
            }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: UploadTableViewCell.identifier, for : indexPath) as! UploadTableViewCell
            customCell.configure(with: "Write the title", imageName: "picture")
            return customCell
            
        }
        else
        if indexPath.row == 1
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: AddCoverTableViewCell.identifier, for : indexPath) as! AddCoverTableViewCell
            customCell.configure(with: "Add Cover", imageName: "camera 1")
            return customCell
        }
        else
        if indexPath.row == 2
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: albumTitleTableViewCell.identifier, for : indexPath) as! albumTitleTableViewCell
            customCell.configure(with: "ALBUM", imageName: "picture")
            return customCell
        }
        else
            if indexPath.row == 3
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: albumListTableViewCell.identifier, for : indexPath) as! albumListTableViewCell
            customCell.configure(with: "Album title", imageName: "picture")
            return customCell
        }
        else
        if indexPath.row == 4
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.identifier, for : indexPath) as! GenreTableViewCell
            customCell.configure(with: "GENRE", title: "choose the genre")
            return customCell
        }
        else
            if indexPath.row == 5
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: descTitleTableViewCell.identifier, for : indexPath) as! descTitleTableViewCell
            customCell.configure(with: "DESCRIPTION", imageName: "Write a description")
            return customCell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Cover Song"
            
            let theSwitch = UISwitch()
            cell.accessoryView = theSwitch
            
             return cell
        }

    func didChangeSwitch( sender: UISwitch)
    {
        if sender.isOn {
            print("Cover song selected")
        }
        else
        {
            print("Cover song not selected")
        }
    
    }
  
        
        
     
}

}
