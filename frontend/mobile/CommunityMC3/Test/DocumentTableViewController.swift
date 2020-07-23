//
//  ContactTableViewController.swift
//  StarterCloudkit
//
//  Created by Jazilul Athoya on 09/07/20.
//  Copyright © 2020 Jazilul Athoya. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class Upload: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var name: String!
    var file: URL!
}

class DocumentTableViewController: UITableViewController {
    
//    var documents: [String] = []
    var documents: [CKRecord] = []
    var uploads: [Upload] = []
    var selectRow = 0
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFromCloudKit()
    }
    
    func getFromDevice() {
        let file = AppFile()
    //        _ = file.writeFile(containing: "This file was written for my tutorial on the iOS 11 Files app.\n\nThe text file was written to this app\'s Documents folder.", to: .Documents, withName: "textFile1.txt")
        let fetchedDocuments = file.list()
        print(fetchedDocuments)
        
        if fetchedDocuments.count > 0 {
    //            print(fetchedDocuments[0])
            for document in fetchedDocuments {
                var temp = document
                temp = String(temp.dropFirst())
                temp = String(temp.dropLast())
    //                        self.documents.append(temp)
            }
    //                    print(file.readFile(at: .Documents, withName: self.documents[0]))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getFromCloudKit() {
        // 1. tunjuk databasenya apa
               let database = CKContainer(identifier: "iCloud.ada.mc3.music").publicCloudDatabase
               
               // 2. kita tentuin recordnya
               let predicate = NSPredicate(value: true)
               let query = CKQuery(recordType: "Uploads", predicate: predicate)
               
               // 3. execute querynya
               database.perform(query, inZoneWith: nil) { records, error in
                   
                   if let err = error {
                       print(err.localizedDescription)
                   }
                   
                   print(records)
                   
                   if let fetchedRecords = records {
                    for record in fetchedRecords {
                        let temp = Upload()
                        temp.name = record.value(forKey: "name") as? String
                        temp.recordID = record.recordID
                        self.uploads.append(temp)
                    }
                       self.documents = fetchedRecords
                       DispatchQueue.main.async {
                           self.tableView.reloadData()
                       }
                   }
               }
    }
    
    func downloadDocument(upload: Upload) {
//        let spinner = UIActivityIndicatorView(style: .gray)
//        spinner.tintColor = UIColor.black
//        spinner.startAnimating()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)

        CKContainer(identifier: "iCloud.ada.mc3.music").publicCloudDatabase.fetch(withRecordID: upload.recordID) { [unowned self] record, error in
            if let error = error {
                DispatchQueue.main.async {
                    // meaningful error message here!
                    print(error.localizedDescription)
//                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(self.downloadTapped))
                }
            } else {
                if let record = record {
                    if let asset = record["fileData"] as? CKAsset {
                        upload.file = asset.fileURL

                        DispatchQueue.main.async {
//                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Listen", style: .plain, target: self, action: #selector(self.listenTapped))
                            do {
                                self.audioPlayer = try AVAudioPlayer(contentsOf: upload.file)
                                self.audioPlayer.play()
                            } catch {
                                print("play failed")
//                                let ac = UIAlertController(title: "Playback failed", message: "There was a problem playing your whistle; please try re-recording.", preferredStyle: .alert)
//                                ac.addAction(UIAlertAction(title: "OK", style: .default))
//                                present(ac, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let record = documents[indexPath.row]
        
//        cell.textLabel?.text = record
        cell.textLabel?.text = record.value(forKey: "name") as? String
//        cell.detailTextLabel?.text = record.value(forKey: "email") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectRow = indexPath.row
//        self.performSegue(withIdentifier: "uploadTest", sender: self)
        downloadDocument(upload: self.uploads[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "uploadTest" {
//            if let mainPage = segue.destination as? UploadController {
//                mainPage.document = documents[selectRow]
//            }
//        }
    }
    
}
