//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 22/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    private var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(groupInfoUpdate), name: NSNotification.Name(NOTIFY_GROUPS_CHANGED), object: nil)
        groupInfoUpdate()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UI_GROUP_TABLE_CELL_ID) as? GroupTableViewCell else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.configure(forGroup: group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(identifier: STORYBOARD_ID_GROUP_FEED) as? GroupFeedViewController else { return }
        let group = groups[indexPath.row]
        groupFeedVC.configure(forGroup: group)
        present(groupFeedVC, animated: true, completion: nil)
    }
    
    @objc private func groupInfoUpdate() {
        DataService.instance.getAllGroups { (groups) in
            self.groups = groups
            self.tableView.reloadData()
        }
    }
}

