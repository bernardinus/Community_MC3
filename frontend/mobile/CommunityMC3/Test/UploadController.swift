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
import MediaPlayer

class UploadController: UIViewController {
    var document: String!
    
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
        openMediaPlayer()
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

        CKContainer(identifier: "iCloud.ada.mc3.music").publicCloudDatabase.save(musicRecord) { [unowned self] record, error in
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
