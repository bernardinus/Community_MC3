//
//  DataManager.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class DataManager
{
    private static var instance:DataManager!
    static func shared() -> DataManager
    {
        if instance == nil
        {
            instance = DataManager()
        }
        return instance
    }
    
    var selectedTrackData:TrackDataStruct? = nil
    var selectedVideoData:VideosDataStruct? = nil
    
    var trendingNowList:[TrackDataStruct]? = nil
    var latestList:[UploadedDataStruct]? = nil
    var featuredArtistList:[UserDataStruct]? = nil
    var featuredVideoLis:[VideosDataStruct]? = nil
    
    
    private init()
    {
        print("dataManager.init")
    }
}
