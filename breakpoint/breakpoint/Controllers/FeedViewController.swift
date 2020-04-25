//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 22/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var messages = [Message]()
    
    @IBOutlet weak var feedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.delegate = self
        feedTable.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(messagesUpdated), name: NSNotification.Name(NOTIFY_MESSAGES_CHANGED), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateMessages()
    }

    @objc func messagesUpdated() {
        updateMessages()
    }
    
    private func updateMessages() {
        DataService.instance.getAllFeedMessage(handler: { (returnedMessages) in
            self.messages = returnedMessages.reversed()
            self.feedTable.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UI_FEED_TABLE_CELL_ID) as? FeedTableViewCell else { return UITableViewCell() }
        
        let image = UIImage.init(named: "defaultProfileImage")!
        let message = messages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderID) { (username) in
            cell.setupCell(profileImage: image, userId: message.senderID, content: message.content)
        }
        
        return cell
    }
    
    
}

