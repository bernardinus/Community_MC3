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
    
    @IBOutlet weak var uploadButton: UIBarButtonItem!
    //    var documents: [String] = []
    var documents: [CKRecord] = []
    var uploads: [Upload] = []
    var selectRow = 0
    var audioPlayer: AVAudioPlayer!
    
    var selectedVideo: URL!
    
    static let shared  = DocumentTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadVideo(_ sender: UIBarButtonItem) {
        openCameraAndLibrary()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUploadsFromCloudKit(tableView: self.tableView) { (records) in
            self.documents = records
        }
//        getFromCloudKit()
//        getFilmsFromCloudKit { (videos) in
//            if videos.count > 0 {
//                let videoURL = videos[0].fileURL
//                let player = AVPlayer(url: videoURL)
//                let playerLayer = AVPlayerLayer(player: player)
//                playerLayer.frame = self.view.bounds
//                self.view.layer.addSublayer(playerLayer)
//                player.play()
//            }
//        }
    }
    
    func getFavoritesFromCloudKit(completionHandler: @escaping ([FavouritesDataStruct]) -> Void){
        var favourites = [FavouritesDataStruct]()
        // 1. tunjuk databasenya apa
           let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
           
           // 2. kita tentuin recordnya
           let predicate = NSPredicate(value: true)
           let query = CKQuery(recordType: "Favourites", predicate: predicate)
           
           // 3. execute querynya
           database.perform(query, inZoneWith: nil) { records, error in
               
               if let err = error {
                   print(err.localizedDescription)
               }
               
               print(records)
               
               if let fetchedRecords = records {
                for record in fetchedRecords {
                    let trackData = try? JSONDecoder().decode([PrimitiveTrackDataStruct].self, from: record.value(forKey: "tracks") as! Data)
                    let videoData = try? JSONDecoder().decode([PrimitiveVideosDataStruct].self, from: record.value(forKey: "video") as! Data)
                    let temp = FavouritesDataStruct(
                        id: (record.value(forKey: "id") as? String)!,
                        track: trackData!,
                        videos: videoData!
                    )
                    favourites.append(temp)
                }
                completionHandler(favourites)
               }
           }
    }
    
    func uploadFavorite(id: String, track: [PrimitiveTrackDataStruct]?) {
//        guard let arrayTrack = track else { return }
//        do{
            let trackData = try? JSONEncoder().encode(track)
            var musicRecord = CKRecord(recordType: "Favourites")
//            let musicRecord = CKRecord(recordType: "Favourites", recordID: recordID)
            //Parent record (Aircraft)
//            let recordAircraft = CKRecord(recordType: "Aircraft", recordID: ...)
//
//            //Add child references (FieldValue). As far as I know, the child records must have already been created and sent to CloudKit
//            var fieldValueReferences = [CKRecord.Reference]()
//
//            for fieldValue in fieldValues{
//              let ref = CKReference(record: fieldValue, action: .deleteSelf)
//              fieldValueReferences.append(ref)
//            }
//
        // 1. tunjuk databasenya apa
           let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
           
           // 2. kita tentuin recordnya
           let predicate = NSPredicate(value: true)
           let query = CKQuery(recordType: "Favourites", predicate: predicate)
        
           
           // 3. execute querynya
           database.perform(query, inZoneWith: nil) { records, error in
               
               if let err = error {
                   print(err.localizedDescription)
               }
               
               print(records)
               
               if let fetchedRecords = records {
                var flag = false
                for record in fetchedRecords {
                    let email = (record.value(forKey: "id") as? String)!
                    let favouriteData = try? JSONDecoder().decode([PrimitiveTrackDataStruct].self, from: record.value(forKey: "tracks") as! Data)
                    if email == id && favouriteData!.count != trackData!.count {
//                        print("bener")
                        flag = true
                        musicRecord = record
                        musicRecord["tracks"] = trackData
                        database.save(musicRecord) { [unowned self] record, error in
                            DispatchQueue.main.async {
                                if let error = error {
                                    print("Error: \(error.localizedDescription)")
                                } else {
                                    print("Done!")
                                }
                            }
                        }
                    }
                }
                if !flag {
//                    print("salah")
                    musicRecord["id"] = id as CKRecordValue
                    musicRecord["tracks"] = trackData
                    database.save(musicRecord) { [unowned self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                            } else {
                                print("Done!")
                            }
                        }
                    }
                }
               }
           }
        
        
//            //Assign the array of references to the key that represents your Reference List field
//            recordAircraft["fieldValues"] = fieldValueReferences as CKRecordValue
//            musicRecord["track"] = fieldValueReferences as CKRecordValue
    //        musicRecord["videos"] = (video! as CKRecordValue)
        
//        }catch{print("error")}

    }
    
    func uploadTrack(email: String, genre: String, name: String, fileURL: URL) {
        let musicRecord = CKRecord(recordType: "Track")
        musicRecord["genre"] = genre as CKRecordValue
        musicRecord["name"] = name as CKRecordValue
        musicRecord["email"] = email as CKRecordValue

//        let audioURL = UploadController.getMusicURL(document: document)
        let musicAsset = CKAsset(fileURL: fileURL)
        musicRecord["fileData"] = musicAsset

        CKContainer(identifier: iCloudContainerID).publicCloudDatabase.save(musicRecord) { [unowned self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Done!")
                }
            }
        }
    }
    
    func uploadFilm(name: String, email: String, genre: String, myVideo: URL?) {
        let profileRecord = CKRecord(recordType: "Videos")
        profileRecord["genre"] = genre as CKRecordValue
        profileRecord["name"] = name as CKRecordValue
        profileRecord["email"] = email as CKRecordValue
        
        if let videoURL = myVideo {
          do {
               let videoData = try Data(contentsOf: videoURL)
                let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
                do {
                    try videoData.write(to: url!, options: [])
                } catch let e as NSError {
                    print("Error! \(e)");
                    return
                }
                profileRecord["fileData"] = CKAsset(fileURL: url!)

                CKContainer(identifier: iCloudContainerID).publicCloudDatabase.save(profileRecord) { record, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else {
                            // Delete the temporary file
                            do { try FileManager.default.removeItem(at: url!) }
                            catch let e { print("Error deleting temp file: \(e)") }
                            print("Done!")
                        }
                    }
                }
             } catch let error {
               print(error)
             }
        }
    }
    
    func getFilmsFromCloudKit(completionHandler: @escaping ([CKRecord]) -> Void) {
        var videos = [CKRecord]()
        // 1. tunjuk databasenya apa
           let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
           
           // 2. kita tentuin recordnya
           let predicate = NSPredicate(value: true)
           let query = CKQuery(recordType: "Videos", predicate: predicate)
           
           // 3. execute querynya
           database.perform(query, inZoneWith: nil) { records, error in
               
               if let err = error {
                   print(err.localizedDescription)
               }
               
               print(records)
               
               if let fetchedRecords = records {
                for record in fetchedRecords {
//                    let asset = (record.value(forKey: "fileData") as? CKAsset)!
//                    let temp = VideosDataStruct(
//                        genre: (record.value(forKey: "genre") as? String)!,
//                        name: (record.value(forKey: "name") as? String)!,
//                        email: (record.value(forKey: "email") as? String)!,
//                        fileURL: asset.fileURL!
//                    )
//                    videos.append(temp)
                    videos.append(record)
                }
                completionHandler(videos)
               }
           }
//            print("panjang ", tracks.count)
    }
    
    func uploadProfile(name: String, email: String, genre: String, myImage: UIImage) {
//        let profileRecord = CKRecord(recordType: "Profiles")
        let profileRecord = CKRecord(recordType: "UserData")
        profileRecord["genre"] = genre as CKRecordValue
        profileRecord["name"] = name as CKRecordValue
        profileRecord["email"] = email as CKRecordValue

        
        let data = myImage.pngData(); // UIImage -> NSData, see also UIImageJPEGRepresentation
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        do {
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        profileRecord["fileData"] = CKAsset(fileURL: url!)

        CKContainer(identifier: iCloudContainerID).publicCloudDatabase.save(profileRecord) { record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    // Delete the temporary file
                    do { try FileManager.default.removeItem(at: url!) }
                    catch let e { print("Error deleting temp file: \(e)") }
                    print("Done!")
                }
            }
        }
    }
    
    func getProfilesFromCloudKit(completionHandler: @escaping ([CKRecord]) -> Void) {
        var photos = [CKRecord]()
        // 1. tunjuk databasenya apa
           let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
           
           // 2. kita tentuin recordnya
           let predicate = NSPredicate(value: true)
           let query = CKQuery(recordType: "Profiles", predicate: predicate)
           
           // 3. execute querynya
           database.perform(query, inZoneWith: nil) { records, error in
               
               if let err = error {
                   print(err.localizedDescription)
               }
               
               print(records)
               
               if let fetchedRecords = records {
                for record in fetchedRecords {
//                    let temp = Upload()
//                    let temp = TrackDataClass()
//                    let asset = (record.value(forKey: "fileData") as? CKAsset)!
//                    let temp = PhotoDataStruct(
//                        fileURL: asset.fileURL!,
//                        email: (record.value(forKey: "email") as? String)!,
//                        genre: (record.value(forKey: "genre") as? String)!,
//                        name: (record.value(forKey: "name") as? String)!
//                    )
//                    temp.audioData = try AVAudioPlayer(contentsOf: asset.fileURL)
                    
//                    temp.name = record.value(forKey: "name") as? String
//                    temp.recordID = record.recordID
                    photos.append(record)
//                    self.uploads.append(temp)
                }
                completionHandler(photos)
               }
           }
//            print("panjang ", tracks.count)
    }
    
    func getFromDevice(){
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
    
    func getUploadsFromCloudKit(tableView: UITableView, completionHandler: @escaping ([CKRecord]) -> Void){
        var tracks = [CKRecord]()
        // 1. tunjuk databasenya apa
           let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
           
           // 2. kita tentuin recordnya
           let predicate = NSPredicate(value: true)
           let query = CKQuery(recordType: "Uploads", predicate: predicate)
//        let query = CKQuery(recordType: "Tracks", predicate: predicate)
           
           // 3. execute querynya
           database.perform(query, inZoneWith: nil) { records, error in
               
               if let err = error {
                   print(err.localizedDescription)
               }
               
               print(records)
               
               if let fetchedRecords = records {
                for record in fetchedRecords {
//                    let temp = Upload()
//                    let temp = TrackDataClass()
//                    let asset = (record.value(forKey: "fileData") as? CKAsset)!
//                    let temp = TrackDataStruct(
//                        genre: (record.value(forKey: "genre") as? String)!,
//                        name: (record.value(forKey: "name") as? String)!,
//                        recordID: record.recordID,
//                        email: (record.value(forKey: "email") as? String)!,
//                        fileURL: asset.fileURL!
//                    )
//                    temp.audioData = try AVAudioPlayer(contentsOf: asset.fileURL)
                    
//                    temp.name = record.value(forKey: "name") as? String
//                    temp.recordID = record.recordID
//                    tracks.append(temp)
                    tracks.append(record)
//                    self.uploads.append(temp)
                }
//                   self.documents = fetchedRecords
                   DispatchQueue.main.async {
//                       self.tableView.reloadData()
                    tableView.reloadData()
                   }
                completionHandler(tracks)
               }
           }
//            print("panjang ", tracks.count)
    }
    
    func downloadDocument(upload: TrackDataStruct) {
//        let spinner = UIActivityIndicatorView(style: .gray)
//        spinner.tintColor = UIColor.black
//        spinner.startAnimating()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)

//        CKContainer(identifier: "iCloud.ada.mc3.music").publicCloudDatabase.fetch(withRecordID: upload.recordID) { [unowned self] record, error in
//            if let error = error {
//                DispatchQueue.main.async {
                    // meaningful error message here!
//                    print(error.localizedDescription)
//                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(self.downloadTapped))
//                }
//            } else {
//                if let record = record {
//                    if let asset = record["fileData"] as? CKAsset {
//                        upload.file = asset.fileURL
//                        upload.fileURL = asset.fileURL!

        DispatchQueue.main.async {
//                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Listen", style: .plain, target: self, action: #selector(self.listenTapped))
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: upload.fileURL)
                self.audioPlayer.play()
            } catch {
                print("play failed")
//                                let ac = UIAlertController(title: "Playback failed", message: "There was a problem playing your whistle; please try re-recording.", preferredStyle: .alert)
//                                ac.addAction(UIAlertAction(title: "OK", style: .default))
//                                present(ac, animated: true)
            }
        }
                        
//                    }
//                }
//            }
//        }
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
//        downloadDocument(upload: self.uploads[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "uploadTest" {
//            if let mainPage = segue.destination as? UploadController {
//                mainPage.document = documents[selectRow]
//            }
//        }
    }
    
}

// Extension to make more structured
extension DocumentTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Func to open camera and library function
    func openCameraAndLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionAlert = UIAlertController(title: "Browse attachment", message: "Choose source", preferredStyle: .alert)
        actionAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated:true, completion: nil)
            }else{
                print("Camera is not available at this device")
            }
        })) // give an option in alert controller to open camera
        
        actionAlert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.movie"]
            self.present(imagePicker, animated:true, completion: nil)
        })) // give the second option in alert controller to open Photo library
        
        actionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) // give the third option in alert controller to cancel the form
        
        self.present(actionAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        print("masuk")
        if let videoURL = info[.mediaURL] as? URL {
//            print("lebih")
            picker.videoExportPreset = AVAssetExportPresetPassthrough
            picker.dismiss(animated: true) {
                self.selectedVideo = videoURL
                print(videoURL)
                self.uploadFilm(name: "test", email: "mnb@mnb", genre: "Pop", myVideo: videoURL)
            }
        }
    }
}

