//
//  SwitchAccountTableViewCell.swift
//  Allegro
//
//  Created by Bryanza on 05/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SwitchAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var switchAccountImage: UIImageView!
    @IBOutlet weak var switchAccountName: UILabel!
    @IBOutlet weak var switchAccountRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
