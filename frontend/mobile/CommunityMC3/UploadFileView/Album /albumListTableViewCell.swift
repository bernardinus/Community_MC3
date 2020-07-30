//
//  albumListTableViewCell.swift
//  MC3 Table View Test
//
//  Created by Nur Minnuri Qalbi on 22/07/20.
//  Copyright © 2020 Nur Minnuri Qalbi. All rights reserved.
//

import UIKit

class albumListTableViewCell: UITableViewCell {
    
    
    static let identifier = "albumListTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "albumListTableViewCell", bundle: nil)
    }
    
    public func configure (with title: String, imageName: String) {
        albumTitleLabel.text = title
        albumTrackLabel.text = title
        albumCoverImage.image = UIImage(named: imageName)
    }
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumTrackLabel: UILabel!
    @IBOutlet weak var noAlbumTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumCoverImage.image = UIImage(named: "no_album")
        albumTitleLabel.isHidden = true
        albumTrackLabel.isHidden = true
        noAlbumTextField.isHidden = false
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
