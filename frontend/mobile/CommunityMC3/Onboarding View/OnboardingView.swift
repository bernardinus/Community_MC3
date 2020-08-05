//
//  OnboardingView.swift
//  Allegro
//
//  Created by Theofani on 05/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class OnboardingView: UIViewController {
    
    var onboardingVC: OnboardingCarouselView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onboardingViewSegue"
        {
            print("onboardingSegue")
            onboardingVC = (segue.destination as! OnboardingCarouselView)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
