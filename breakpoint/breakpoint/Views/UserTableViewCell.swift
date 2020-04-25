//
//  UserTableViewCell.swift
//  breakpoint
//
//  Created by Chris Mercer on 24/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    
    var showing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing {
                checkmark.isHidden = true
                showing = false
            } else {
                checkmark.isHidden = false
                showing = true
            }
        }
    }

    func configure(profileImage image: UIImage, email: String, isSelected: Bool) {
        profileImage.image = image
        emailAddress.text = email
        checkmark.isHidden = !isSelected
    }
}
