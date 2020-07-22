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
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func getMusicURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
    
    func startUploading() {
        // 3
        let audioURL = UploadController.getMusicURL()
        print(audioURL.absoluteString)

        // 4
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
    }
    
    func doSubmission() {
        let musicRecord = CKRecord(recordType: "Uploads")
//        musicRecord["genre"] = genre as CKRecordValue
//        musicRecord["comments"] = comments as CKRecordValue

        let audioURL = UploadController.getMusicURL()
        let musicAsset = CKAsset(fileURL: audioURL)
        musicRecord["audio"] = musicAsset

        CKContainer(identifier: "iCloud.ada.mc3.music").publicCloudDatabase.save(musicRecord) { [unowned self] record, error in
            DispatchQueue.main.async {
//                if let error = error {
//                    self.status.text = "Error: \(error.localizedDescription)"
//                    self.spinner.stopAnimating()
//                } else {
//                    self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
//                    self.status.text = "Done!"
//                    self.spinner.stopAnimating()
//
//                    ViewController.isDirty = true
//                }
//
//                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
            }
        }
    }
}

extension UploadController: MPMediaPickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Func to open media library function
    func openMediaPlayer() {
        let picker = MPMediaPickerController(mediaTypes: .anyAudio)
        picker.delegate = self
        picker.allowsPickingMultipleItems = false
        picker.prompt = "Choose a song"
        present(picker, animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        let mediaItems = MPMediaQuery.songs().items
        let mediaCollection = MPMediaItemCollection(items: mediaItems ?? [])
        let player = MPMusicPlayerController.systemMusicPlayer
        player.setQueue(with: mediaCollection)
        player.play()
    }
}
