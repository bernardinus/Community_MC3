//
//  ShowcaseTableCell.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class ShowcaseHeaderCell: UITableViewCell {

    @IBOutlet weak var showcaseSectionHeader: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapSeeAll(_ sender: Any) {
    }
}
