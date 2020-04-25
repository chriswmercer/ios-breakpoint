//
//  GroupFeedViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 25/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit
import Firebase

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
        tableView.delegate = self
        tableView.dataSource = self
        senderTextView.bindToKeyboard()
        
        guard let currentGroup = group else { return }
        self.groupTitleLabel.text = currentGroup.name
        
        DataService.instance.getEmails(forGroup: currentGroup) { (emails) in
            let memberList = emails.joined(separator: ", ")
            self.members.text = "members[\(memberList)]"
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!) { (returnedMessage) in
                self.messages = returnedMessage
                self.tableView.reloadData()
                
                if self.messages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .none, animated: true)
                }
            }
        }
    }
    
    func configure(forGroup group: Group) {
        self.group = group
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if messageText.text == "" { return }
        
        DataService.instance.uploadPost(withMessage: messageText.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (success) in
            self.messageText.text = ""
        }
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
