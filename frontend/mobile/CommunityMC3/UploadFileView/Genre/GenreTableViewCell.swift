//
//  GenreTableViewCell.swift
//  MC3 Table View Test
//
//  Created by Nur Minnuri Qalbi on 22/07/20.
//  Copyright © 2020 Nur Minnuri Qalbi. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    
    static let identifier = "GenreTableViewCell"
    @IBOutlet weak var genreTextField: UITextField!
    
    static func nib() -> UINib {
        return UINib(nibName: "GenreTableViewCell", bundle: nil)
    }
    
    public func configure (with label: String, title: String) {
        genreLabel.text = label
        //genreTextField.text = title
    }
    
    @IBOutlet var genreLabel: UILabel!
//    @IBOutlet var genreTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        genreLabel.text = NSLocalizedString("Genre", comment: "")
        genreTextField.placeholder = NSLocalizedString("Choose your genre".uppercased(), comment: "")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
