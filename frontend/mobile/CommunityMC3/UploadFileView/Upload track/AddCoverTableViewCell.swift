//
//  AddCoverTableViewCell.swift
//  MC3 Table View Test
//
//  Created by Nur Minnuri Qalbi on 20/07/20.
//  Copyright © 2020 Nur Minnuri Qalbi. All rights reserved.
//

import UIKit

class AddCoverTableViewCell: UITableViewCell {
    
    static let identifier = "AddCoverTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AddCoverTableViewCell", bundle: nil)
    }
    
    public func configure (with title: String, imageName: String)
    {
        addCoverLabel.text = title
        addCoverImage.image = UIImage(named: imageName)
    }
    
    @IBOutlet var addCoverImage: UIImageView!
    @IBOutlet var addCoverLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        addCoverLabel.text = NSLocalizedString("Cover image".uppercased(), comment: "")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
