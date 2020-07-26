//
//  FileManager.swift
//  CommunityMC3
//
//  Created by Bernardinus on 23/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class FileManagers
{
    private static let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    
    class func getAvailableAudioFiles() -> [URL]
    {
        return FileManagers.getFileList(availableAudioFilesExt)
    }
    
    class func getAvailableMusicFiles() -> [URL]
    {
        return FileManagers.getFileList(availableVideoFilesExt)
    }
    
    
    class func getFileList(_ filter:[String] = []) -> [URL]
    {
        do {
            
            print(documentsUrl)
            
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            
            var filteredFiles = directoryContents
            if(filter.count > 0)
            {
                filteredFiles = directoryContents.filter({ (url) -> Bool in
                    filter.contains(url.pathExtension)
                })
            }
            
            return filteredFiles
        } catch {
            print(error)
            return []
        }
    }
    
}
