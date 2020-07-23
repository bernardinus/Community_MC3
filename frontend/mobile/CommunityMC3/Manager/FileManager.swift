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
    
    class func getFileList() -> [URL]
    {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            return directoryContents
        } catch {
            print(error)
            return []
        }
    }
    
}
