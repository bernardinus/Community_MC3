//
//  RandomSpotlightViewController.swift
//  CommunityMC3
//
//  Created by Rommy Julius Dwidharma on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit


class RandomSpotlightViewController: UIViewController{

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var innerCircleEffectImage: UIImageView!
    @IBOutlet weak var outerCircleEffectImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    var test = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
    }
    
    func setupBackground(){
        //set gradient background in view
        let viewBackground = CAGradientLayer()
        viewBackground.colors = [#colorLiteral(red: 0.8862745098, green: 0.03529411765, blue: 0.168627451, alpha: 1).cgColor, #colorLiteral(red: 0.2823529412, green: 0.003921568627, blue: 0.7843137255, alpha: 1).cgColor]
        viewBackground.frame = view.frame
        view.layer.insertSublayer(viewBackground, at: 0)
        view.bringSubviewToFront(contentView)
        
        //set to white color
        titleLabel.textColor = UIColor.white
        statusLabel.textColor = UIColor.white
        editButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 2.0, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                self.outerCircleEffectImage?.transform = CGAffineTransform (scaleX:1.25 , y: 1.25)
            })
        }, completion: {(_ finished: Bool) -> Void in
            self.outerCircleEffectImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        UIView.animate(withDuration: 2.0, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                self.innerCircleEffectImage?.transform = CGAffineTransform (scaleX:1.15 , y: 1.15)
            })
        }, completion: {(_ finished: Bool) -> Void in
            self.innerCircleEffectImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        UIView.animate(withDuration: 2.0, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true, animations: {
                self.searchButton?.transform = CGAffineTransform (scaleX:0.9 , y: 0.9)
            })
        }, completion: {(_ finished: Bool) -> Void in
            self.searchButton?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        
        
    }
    @IBAction func editButtonAction(_ sender: UIButton) {
        let editRandomizerVC = storyboard?.instantiateViewController(identifier: "EditRandomizerVC") as! EditRandomizerViewController
        editRandomizerVC.transitioningDelegate = self
        editRandomizerVC.modalPresentationStyle = .custom
        editRandomizerVC.view.layer.cornerRadius = 34
     
        self.present(editRandomizerVC, animated: true, completion: nil)
        
    }
    
}
extension RandomSpotlightViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
        }
    }
}

