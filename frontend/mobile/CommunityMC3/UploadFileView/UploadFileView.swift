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
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var uploadFileTitleLabel: UILabel!
    
    var videoData:VideosDataStruct?
    var trackData:TrackDataStruct?
    var isUploadVideo:Bool = false
    
    var coverImage:UIImageView?
    var tapRecognizer:UIGestureRecognizer?
    
    
    // genre
    var selectedGenre:String = ""
    var genreTextField:UITextField?
    var pickerView:UIPickerView = UIPickerView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pickerView.delegate = self
        uploadFileTitleLabel.text = "Upload"
        
        table.register(UploadTableViewCell.nib(), forCellReuseIdentifier: UploadTableViewCell.identifier)
        table.register(AddCoverTableViewCell.nib(), forCellReuseIdentifier: AddCoverTableViewCell.identifier)
        table.register(GenreTableViewCell.nib(), forCellReuseIdentifier: GenreTableViewCell.identifier)
        table.register(albumTitleTableViewCell.nib(), forCellReuseIdentifier: albumTitleTableViewCell.identifier)
        table.register(albumListTableViewCell.nib(), forCellReuseIdentifier: albumListTableViewCell.identifier)
        table.register(descTitleTableViewCell.nib(), forCellReuseIdentifier: descTitleTableViewCell.identifier)
        table.register(UploadFileHeaderCell.nib(), forCellReuseIdentifier: UploadFileHeaderCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = false
        
        table.separatorColor = UIColor.clear
    }
    
    @IBAction func cancelButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didChangeSwitch(_ sender: UISwitch!)
    {
        if sender.isOn {
            print("Cover song selected")
        }
        else
        {
            print("Cover song not selected")
        }
        
    }
    
    @IBAction func uploadFileButtonTouched()
    {
        if isUploadVideo
        {
            
        }
        else
        {
            
        }
    }
    
    func setupDelegate()
    {
        coverImage?.image = UIImage(color: .red, size: coverImage!.image!.size)
        print("setupDelegate")
    }
}

extension UploadFileView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 85 // 70
        }
        if indexPath.row == 1
        {
            return 87 // 70
        }
        if indexPath.row == 2
        {
            return 70
        }
        if indexPath.row == 3
        {
            return 70
        }
        if indexPath.row == 4
        {
            return 80
        }
        if indexPath.row == 5
        {
            
            return 225
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
        else if indexPath.row == 1
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: AddCoverTableViewCell.identifier, for : indexPath) as! AddCoverTableViewCell
            customCell.configure(with: "Add Cover", imageName: "camera 1")
            
            coverImage = customCell.addCoverImage
            
            setupDelegate()
            
            
            return customCell
        }
        else if indexPath.row == 2
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: albumTitleTableViewCell.identifier, for : indexPath) as! albumTitleTableViewCell
            customCell.configure(with: "ALBUM", imageName: "picture")
            return customCell
        }
        else if indexPath.row == 3
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: albumListTableViewCell.identifier, for : indexPath) as! albumListTableViewCell
            customCell.configure(with: "Album title", imageName: "picture")
            return customCell
        }
        else if indexPath.row == 4
        {
            let customCell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.identifier, for : indexPath) as! GenreTableViewCell
            customCell.configure(with: "GENRE", title: "choose the genre")
            
            genreTextField = customCell.genreTextField
            genreTextField?.delegate = self
            genreTextField?.inputView = pickerView
            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
            toolBar.setItems([button], animated: true)
            toolBar.isUserInteractionEnabled = true
            genreTextField!.inputAccessoryView = toolBar
            
            
            return customCell
        }
        else if indexPath.row == 5 // Description
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
            theSwitch.target(forAction: #selector(didChangeSwitch(_ :)), withSender: theSwitch)
            cell.accessoryView = theSwitch
            
            return cell
        }
        
    }
    @objc func action() {
        view.endEditing(true)
    }
    
}

extension UploadFileView:UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}

extension UploadFileView:UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        musicGenreArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        musicGenreArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGenre = musicGenreArray[row]
        genreTextField?.text = selectedGenre
    }
    
}
