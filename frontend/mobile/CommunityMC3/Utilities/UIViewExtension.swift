//
//  UIView+Extension.swift
//  Allegro
//
//  Created by Bernardinus on 07/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func slideLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let slideFromRightToLeft = CATransition()
        
        if let delegate: AnyObject = completionDelegate {
            slideFromRightToLeft.delegate = (delegate as! CAAnimationDelegate)
        }
        slideFromRightToLeft.type = CATransitionType.push
        slideFromRightToLeft.subtype = CATransitionSubtype.fromRight
        slideFromRightToLeft.duration = duration
        slideFromRightToLeft.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideFromRightToLeft.fillMode = CAMediaTimingFillMode.removed
        
        self.layer.add(slideFromRightToLeft, forKey: "slideFromRightToLeft")
    }
    //    func slideRight(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil){
    //        let slideFromLeftToRight = CATransition()
    //
    //        if let delegate: AnyObject = completionDelegate {
    //            slideFromLeftToRight.delegate = (delegate as! CAAnimationDelegate)
    //        }
    //        slideFromLeftToRight.type = CATransitionType.push
    //        slideFromLeftToRight.subtype = CATransitionSubtype.fromLeft
    //        slideFromLeftToRight.duration = duration
    //        slideFromLeftToRight.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    //        slideFromLeftToRight.fillMode = CAMediaTimingFillMode.removed
    //
    //        self.layer.add(slideFromLeftToRight, forKey: "slideFromLeftToRight")
    //    }
}
