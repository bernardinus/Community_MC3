//
//  UIViewController+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension UIViewController {
    
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboardFunc))
        tap.cancelsTouchesInView = false; view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboardFunc(){
        print("dismissKeyboard")
        view.endEditing(true)
    }
    
}
