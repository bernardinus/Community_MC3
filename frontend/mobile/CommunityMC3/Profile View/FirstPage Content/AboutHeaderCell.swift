//
//  AboutHeaderCell.swift
//  CommunityMC3
//
//  Created by Theofani on 29/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class AboutHeaderCell: UITableViewCell {

    @IBOutlet weak var aboutHeaderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        aboutHeaderLabel.adjustsFontSizeToFitWidth = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
