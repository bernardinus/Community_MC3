//
//  SelectFileView.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SelectFileView: UIDocumentBrowserViewController
{

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: "SelectViewCell", bundle:nil), forCellReuseIdentifier: "selectViewCell")
        // Do any additional setup after loading the view.
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

}

extension SelectFileView:UIDocumentBrowserViewControllerDelegate
{
    
}

/*
extension SelectFileView:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        
    }
}

extension SelectFileView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "selectViewCell") as! SelectViewCell
        cell.fileName.text = "\(indexPath.row)"
        print("\(indexPath.row)")
        return cell
    }
    
    
}
 */
