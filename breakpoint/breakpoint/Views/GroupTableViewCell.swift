//
//  GroupTableViewCell.swift
//  breakpoint
//
//  Created by Chris Mercer on 25/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(forGroupName group: String, andDescription description: String, withMemberCountOf count: Int) {
        descriptionLabel.text = description
        nameLabel.text = group
        countLabel.text = "member.count = \(count)"
    }
    
    func configure(forGroup group: Group) {
        configure(forGroupName: group.name, andDescription: group.description, withMemberCountOf: group.count)
    }
}
