//
//  StringExtension.swift
//  Allegro
//
//  Created by Bernardinus on 07/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

extension String
{
    func containsInsesitive(string:String) -> Bool
    {
        if let _ = self.range(of: string, options: .caseInsensitive){return true}
        return false
    }
}
