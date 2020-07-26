//
//  descTitleTableViewCell.swift
//  MC3 Table View Test
//
//  Created by Nur Minnuri Qalbi on 22/07/20.
//  Copyright © 2020 Nur Minnuri Qalbi. All rights reserved.
//

import UIKit

class descTitleTableViewCell: UITableViewCell {
    
    static let identifier = "descTitleTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "descTitleTableViewCell", bundle: nil)
    }
    
    public func configure (with title: String, imageName: String) {
        descTitleLabel.text = title
    }
    
    @IBOutlet var descTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
