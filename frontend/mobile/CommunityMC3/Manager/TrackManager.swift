//
//  TrackManager.swift
//  Allegro
//
//  Created by Rommy Julius Dwidharma on 07/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class TrackManager {
    
    static let shared = TrackManager()
    weak var delegate: MiniTrackPlayerDelegate?
    
    init() {}
    
    func play(trackURL: String){
        delegate?.play(trackURL: trackURL)
    }
    
    func stop() {
        delegate?.stop()
    }
    func pause(){
        delegate?.pause()
    }
    
}
