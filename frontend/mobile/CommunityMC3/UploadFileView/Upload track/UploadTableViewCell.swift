//
//  UploadTableViewCell.swift
//  MC3 Table View Test
//
//  Created by Nur Minnuri Qalbi on 20/07/20.
//  Copyright © 2020 Nur Minnuri Qalbi. All rights reserved.
//

import UIKit

class UploadTableViewCell: UITableViewCell {

    static let identifier = "UploadTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "UploadTableViewCell", bundle: nil)
    }
    
    public func configure (with title: String, imageName: String) {
        trackCoverTextField.text = title
        //trackCoverImage.image = UIImage(systemName: imageName)
        trackCoverImage.image = UIImage(named: imageName)
    }
    
    @IBOutlet var trackCoverImage: UIImageView!
    @IBOutlet var trackCoverTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
