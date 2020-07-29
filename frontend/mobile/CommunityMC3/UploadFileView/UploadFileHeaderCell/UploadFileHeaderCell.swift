//
//  UploadFileHeaderCell.swift
//  CommunityMC3
//
//  Created by Bernardinus on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class UploadFileHeaderCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static let identifier = "uploadFileHeaderCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "uploadFileHeaderCell", bundle: nil)
    }
    
}
