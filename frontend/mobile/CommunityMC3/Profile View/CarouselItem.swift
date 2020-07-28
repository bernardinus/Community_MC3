//
//  CarouselItem.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//
import Foundation
import UIKit

@IBDesignable
class CarouselItem: UIView {
    static let CAROUSEL_ITEM_NIB = "CarouselItem"
    
    @IBOutlet var viewContent: UIView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    
    //MARK:  - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(titletext: String? = "", background: UIColor? = .red){
        self.init()
        labelText.text = titletext
        viewBackground.backgroundColor = background
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.CAROUSEL_ITEM_NIB, owner: self, options: nil)
        viewContent.frame = bounds
        viewContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(viewContent)
    }
}
