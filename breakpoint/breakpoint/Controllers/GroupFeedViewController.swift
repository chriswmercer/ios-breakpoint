//
//  GroupFeedViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 25/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class GroupFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var senderTextView: UIView!
    @IBOutlet weak var members: UILabel!
    
    private var group: Group?
    private var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderTextView.bindToKeyboard()
        
        guard let currentGroup = group else { return }
        self.groupTitleLabel.text = currentGroup.name
        
        DataService.instance.getEmails(forGroup: currentGroup) { (emails) in
            let memberList = emails.joined(separator: ", ")
            self.members.text = "members[\(memberList)]"
        }
    }
    
    func configure(forGroup group: Group) {
        self.group = group
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UI_GROUP_FEED_TABLE_CELL_ID) as? GroupFeedTableViewCell else { return UITableViewCell() }
        let message = messages[indexPath.row]
        let image = UIImage.init(named: "defaultProfileImage")!
        
        DataService.instance.getUsername(forUID: message.senderID) { (result) in
            cell.configure(forImage: image, andEmail: result, andMessage: message.content)
        }
        
        return cell
    }
    
}
