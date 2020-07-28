//
//  HeaderCell.swift
//  CommunityMC3
//
//  Created by Bernardinus on 20/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var HeaderName: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var sectionBlock: UIView!
    
    var callBack: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func tapSeeMore(_ sender: Any) {
        self.callBack!()
    }
    
    func setCallBack(callback: (() -> Void)?){
        self.callBack = callback
    }
}
