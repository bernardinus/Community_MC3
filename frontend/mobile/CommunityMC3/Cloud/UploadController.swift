//
//  UploadController.swift
//  CommunityMC3
//
//  Created by Bryanza on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AVFoundation
import CloudKit
//import MediaPlayer

class UploadController: UIViewController {
    var document: String!
    var audioPlayer: AVAudioPlayer!
    
    static let shared = UploadController()
    
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if document != nil {
            print(document)
            //            testButton.titleLabel?.text = document
        }
        doSubmission(document: document)
    }
    
    @IBAction func uploadNow(_ sender: UIButton) {
//        openMediaPlayer()
    }
    
    func uploadFavorite(id: String, video: [PrimitiveVideosDataStruct]?) {
        let videoData = try? JSONEncoder().encode(video)
        var videoRecord = CKRecord(recordType: "Favourites")
        
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
                    if email == id {
                        flag = true
                        videoRecord = record
                        videoRecord["video"] = videoData
                        
                        database.save(videoRecord) { [unowned self] record, error in
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
                    videoRecord["id"] = id as CKRecordValue
                    videoRecord["video"] = videoData
                    database.save(videoRecord) { [unowned self] record, error in
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
    }
    
    func uploadUserData(email: String, name: String, genre: String, myImage: UIImage) {
        // 1. buat dulu recordnya
        var newRecord = CKRecord(recordType: "UserData")
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UserData", predicate: predicate)
        
        let data = myImage.pngData(); // UIImage -> NSData, see also UIImageJPEGRepresentation
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        do {
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        newRecord.setValue(CKAsset(fileURL: url!) , forKey: "fileURL")
        
        let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
        
        // 2. execute querynya
        database.perform(query, inZoneWith: nil) { records, error in
            
            if let err = error {
                print(err.localizedDescription)
            }
            
            print(records)
            
            if let fetchedRecords = records {
                var flag = false
                for record in fetchedRecords {
                    let id = (record.value(forKey: "email") as? String)!
                    if email == id {
                        flag = true
                        newRecord = record
                        newRecord.setValue(name , forKey: "name")
                        newRecord.setValue(genre , forKey: "genre")
                        database.save(newRecord) { [unowned self] record, error in
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
                    // 3. set propertynya
                    newRecord.setValue(email , forKey: "email")
                    newRecord.setValue(name , forKey: "name")
                    newRecord.setValue(genre , forKey: "genre")
                    
                    // 4. execute save or insert
                    database.save(newRecord) { record, error in
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
    }
    
    func getUsersDataFromCloudKit(completionHandler: @escaping ([UserDataStruct]) -> Void) {
        var users = [UserDataStruct]()
        // 1. tunjuk databasenya apa
        let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
        
        // 2. kita tentuin recordnya
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UserData", predicate: predicate)
        
        // 3. execute querynya
        database.perform(query, inZoneWith: nil) { records, error in
            
            if let err = error {
                print(err.localizedDescription)
            }
            
            print(records)
            
            if let fetchedRecords = records {
                let registers = fetchedRecords
                for register in registers {
                    let asset = (register.value(forKey: "fileURL") as? CKAsset)!
                    let temp = UserDataStruct(
                        genre: (register.value(forKey: "genre") as? String)!,
                        name: (register.value(forKey: "name") as? String)!,
                        fileURL: asset.fileURL!,
                        email: (register.value(forKey: "email") as? String)!
                    )
                    users.append(temp)
                }
                completionHandler(users)
            }
        }
    }
    
    func uploadAccount(email: String, password: String) {
        // 1. buat dulu recordnya
        let newRecord = CKRecord(recordType: "Account")
        
        // 2. set propertynya
        newRecord.setValue(email , forKey: "email")
        newRecord.setValue(password , forKey: "password")
        
        // 3. execute save or insert
        let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
        
        database.save(newRecord) { record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Done!")
                }
            }
        }
    }
    
    func getAccountsFromCloudKit(completionHandler: @escaping ([AccountDataStruct]) -> Void) {
        var accounts = [AccountDataStruct]()
        // 1. tunjuk databasenya apa
        let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
        
        // 2. kita tentuin recordnya
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Account", predicate: predicate)
        
        // 3. execute querynya
        database.perform(query, inZoneWith: nil) { records, error in
            
            if let err = error {
                print(err.localizedDescription)
            }
            
            print(records)
            
            if let fetchedRecords = records {
                let registers = fetchedRecords
                for register in registers {
                    let temp = AccountDataStruct(
                        email: (register.value(forKey: "email") as? String)!,
                        password: (register.value(forKey: "password") as? String)!
                    )
                    accounts.append(temp)
                }
                completionHandler(accounts)
            }
        }
    }
    
    func getTracksFromCloudKit(tableView: UITableView, completionHandler: @escaping ([TrackDataStruct]) -> Void){
        var tracks = [TrackDataStruct]()
        // 1. tunjuk databasenya apa
        let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
        
        // 2. kita tentuin recordnya
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Tracks", predicate: predicate)
        
        // 3. execute querynya
        database.perform(query, inZoneWith: nil) { records, error in
            
            if let err = error {
                print(err.localizedDescription)
            }
            
            print(records)
            
            if let fetchedRecords = records {
                for record in fetchedRecords {
                    let asset = (record.value(forKey: "fileData") as? CKAsset)!
                    let temp = TrackDataStruct(
                        genre: (record.value(forKey: "genre") as? String)!,
                        name: (record.value(forKey: "name") as? String)!,
//                        recordID: record.recordID,
                        email: (record.value(forKey: "email") as? String)!,
                        fileURL: asset.fileURL!
                    )
                    tracks.append(temp)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                completionHandler(tracks)
            }
        }
    }
    
    func getTrackFromCloudKit(recordID: CKRecord.ID, completionHandler: @escaping (TrackDataStruct) -> Void) {
        CKContainer(identifier: iCloudContainerID).publicCloudDatabase.fetch(withRecordID: recordID) { [unowned self] record, error in
            if let error = error {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            } else {
                if let record = record {
                    if let asset = record["fileURL"] as? CKAsset {
                        let upload = TrackDataStruct(
                            genre: (record.value(forKey: "genre") as? String)!,
                            name: (record.value(forKey: "name") as? String)!,
//                            recordID: record.recordID,
                            email: (record.value(forKey: "email") as? String)!,
                            fileURL: asset.fileURL!
                        )
                        DispatchQueue.main.async {
                            do {
                                self.audioPlayer = try AVAudioPlayer(contentsOf: upload.fileData!.fileURL!)
                                self.audioPlayer.play()
                            } catch {
                                print("play failed")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func downloadVideo(id: CKRecord.ID) {
        
        CKContainer(identifier: iCloudContainerID).publicCloudDatabase.fetch(withRecordID: id) { (results, error) -> Void in
            
            //            dispatch_async(dispatch_get_main_queue()) { () -> Void in
            DispatchQueue.main.async {
                if error != nil {
                    
                    print(" Error Fetching Record  " + error!.localizedDescription)
                } else {
                    if results != nil {
                        print("pulled record")
                        
                        let record = results as CKRecord?
                        let videoFile = record!.value(forKey: "video") as! CKAsset
                        
                        var videoURL = videoFile.fileURL as NSURL?
                        let videoData = NSData(contentsOf: videoURL! as URL)
                        
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("filename.mov", isDirectory: false) //This is where I messed up.
                        
                        FileManager.default.createFile(atPath: (destinationPath?.path)!, contents:videoData as Data?, attributes:nil)
                        
                        videoURL = destinationPath as NSURL?
                        
                        //                        let videoAsset = AVURLAsset(url: videoURL! as URL)
                        //                        self.playVideo()
                        
                    } else {
                        print("results Empty")
                    }
                }
            }
        }
    }
    
    func uploadPhoto(email: String, myImage: UIImage) {
        let photoRecord = CKRecord(recordType: "Photos")
        photoRecord["email"] = email as CKRecordValue
        
        
        let data = myImage.pngData(); // UIImage -> NSData, see also UIImageJPEGRepresentation
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        do {
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        photoRecord["fileData"] = CKAsset(fileURL: url!)
        
        CKContainer(identifier: iCloudContainerID).publicCloudDatabase.save(photoRecord) { record, error in
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
    
    func getPhotosFromCloudKit(completionHandler: @escaping ([ProfilePictureDataStruct]) -> Void) {
        var photos = [ProfilePictureDataStruct]()
        // 1. tunjuk databasenya apa
        let database = CKContainer(identifier: iCloudContainerID).publicCloudDatabase
        
        // 2. kita tentuin recordnya
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Photos", predicate: predicate)
        
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
                    let asset = (record.value(forKey: "fileData") as? CKAsset)!
                    let temp = ProfilePictureDataStruct(
                        fileURL: asset.fileURL!,
                        email: (record.value(forKey: "email") as? String)!
                    )
                    //                    temp.audioData = try AVAudioPlayer(contentsOf: asset.fileURL)
                    
                    //                    temp.name = record.value(forKey: "name") as? String
                    //                    temp.recordID = record.recordID
                    photos.append(temp)
                    //                    self.uploads.append(temp)
                }
                completionHandler(photos)
            }
        }
        //            print("panjang ", tracks.count)
    }
    
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getMusicURL(document: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(document)
    }
    
    func startUploading() {
        // 3
        //        let audioURL = UploadController.getMusicURL()
        //        print(audioURL.absoluteString)
        
        // 4
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
    }
    
    func doSubmission(document: String) {
        let musicRecord = CKRecord(recordType: "Uploads")
        musicRecord["genre"] = "Blues" as CKRecordValue
        musicRecord["name"] = document as CKRecordValue
        musicRecord["email"] = "mnb@mnb" as CKRecordValue
        
        let audioURL = UploadController.getMusicURL(document: document)
        let musicAsset = CKAsset(fileURL: audioURL)
        musicRecord["fileData"] = musicAsset
        
        CKContainer(identifier: iCloudContainerID).publicCloudDatabase.save(musicRecord) { [unowned self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    //                    self.testButton.titleLabel!.text =
                    //                    self.spinner.stopAnimating()
                } else {
                    //                    self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
                    //                    self.testButton.titleLabel!.text = "Done!"
                    //                    self.spinner.stopAnimating()
                    print("Done!")
                    //                    ViewController.isDirty = true
                }
                
                //                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
            }
        }
    }
}
/*
extension UploadController: MPMediaPickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Func to open media library function
    func openMediaPlayer() {
        //        let imagePicker = UIImagePickerController()
        let mediaPicker = MPMediaPickerController(mediaTypes: .anyAudio)
        mediaPicker.delegate  = self
        //        imagePicker.delegate = self
        let actionAlert = UIAlertController(title: "Browse attachment", message: "Choose source", preferredStyle: .alert)
        //        actionAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
        //        actionAlert.addAction(UIAlertAction(title: "Media", style: .default, handler: {
        //            (action:UIAlertAction) in
        //            if UIImagePickerController.isSourceTypeAvailable(.camera) {
        //                imagePicker.sourceType = .camera
        //                self.present(imagePicker, animated:true, completion: nil)
        //            }else{
        //                print("Camera is not available at this device")
        //            }
        //        })) // give an option in alert controller to open camera
        
        //        actionAlert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
        actionAlert.addAction(UIAlertAction(title: "Media Library", style: .default, handler: { (action: UIAlertAction) in
            //            imagePicker.sourceType = .photoLibrary
            //            mediaPicker.mediaTypes = .anyAudio
            //            imagePicker.mediaTypes = ["public.image", "public.movie"]
            //            picker.delegate = self
            mediaPicker.allowsPickingMultipleItems = false
            mediaPicker.prompt = "Choose a song"
            //            present(picker, animated: true, completion: nil)
            self.present(mediaPicker, animated:true, completion: nil)
        })) // give the second option in alert controller to open Photo library
        
        actionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) // give the third option in alert controller to cancel the form
        
        self.present(actionAlert, animated: true, completion: nil)
    }
    
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        //        if let imageTaken = info[.originalImage] as? UIImage {
        //        if let mediaItems = mediaItemCollection.items {
        if let mediaItems = MPMediaQuery.songs().items {
            let mediaCollection = MPMediaItemCollection(items: mediaItems)
            mediaPicker.dismiss(animated: true) {
                //               self.settingImage?.image = imageTaken
                let player = MPMusicPlayerController.systemMusicPlayer
                player.setQueue(with: mediaCollection)
                player.play()
            }
        }
    }
}
*/

//MARK: - Ext. Delegate DocumentPicker
extension UploadController: UIDocumentPickerDelegate {
    func openDocumentPicker() {
        let documentsPicker = UIDocumentPickerViewController(documentTypes: ["public.image", "public.jpeg", "public.png"], in: .open)
        documentsPicker.delegate = self
        documentsPicker.modalPresentationStyle = .fullScreen
        //        self.presentationController?.present(documentsPicker, animated: true, completion: nil)
    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard controller.documentPickerMode == .open, let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
        //        defer { url.stopAccessingSecurityScopedResource() }
        
        guard let image = UIImage(contentsOfFile: url.path) else { return }
        //        self.delegate?.didSelect(image: image)
        controller.dismiss(animated: true)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}
