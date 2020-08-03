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
    @IBOutlet weak var descTextView: UITextView!
    
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
        descTitleLabel.text = NSLocalizedString("Description".uppercased(), comment: "")
        
        descTextView.text = ""
        descTextView.layer.borderWidth = 1
        descTextView.layer.cornerRadius = 5
        descTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
