//
//  FeedTableViewCell.swift
//  breakpoint
//
//  Created by Chris Mercer on 24/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameView: UILabel!
    @IBOutlet weak var feedContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(profileImage: UIImage, userEmail: String, content: String) {
        self.profileImageView.image = profileImage
        self.usernameView.text = userEmail
        self.feedContent.text = content
    }
}
