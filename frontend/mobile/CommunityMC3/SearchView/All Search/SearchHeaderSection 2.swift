//
//  SearchHeaderSection.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SearchHeaderSection: UITableViewCell {
    
    @IBOutlet weak var searchHeaderLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    
    var callBack: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func tapViewAll(_ sender: Any) {
        self.callBack!()
    }
    
    func setCallBack(callback: (() -> Void)?){
        self.callBack = callback
    }
}
