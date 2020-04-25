//
//  GroupFeedTableViewCell.swift
//  breakpoint
//
//  Created by Chris Mercer on 25/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class GroupFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(forImage image: UIImage, andEmail email: String, andMessage message: String) {
        self.profileImage.image = image
        self.emailLabel.text = email
        self.messageLabel.text = message
    }
}
