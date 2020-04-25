//
//  CreateGroupViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 24/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var peopleText: UITextField!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var done: UIButton!
    
    private var emailArary = [String]()
    private var selectedUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        
        self.peopleText.delegate = self
        self.peopleText.addTarget(self, action: #selector(peopleValueChange), for: .editingChanged)
        
        self.titleText.delegate = self
        self.titleText.addTarget(self, action: #selector(checkDoneVisible), for: .editingChanged)
        
        self.descriptionText.delegate = self
        self.descriptionText.addTarget(self, action: #selector(checkDoneVisible), for: .editingChanged)
    }
    
    @IBAction func closeWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneWasPressed(_ sender: Any) {
    }

    @objc func peopleValueChange() {
        guard let value = peopleText.text else { return }
        if value == "" {
            emailArary = []
            userTableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: value) { (results) in
                self.emailArary = results
                self.userTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UI_GROUP_ADD_PEOPLE_CELL_ID) as? UserTableViewCell else { return UITableViewCell() }
        
        let emailAddress = emailArary[indexPath.row]
        let shouldShowSelected = selectedUsers.contains(emailAddress)
        cell.configure(profileImage: UIImage(named: "defaultProfileImage")!, email: emailAddress, isSelected: shouldShowSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell else { return }
        guard let emailAddress = cell.emailAddress.text else { return }
        if !selectedUsers.contains(emailAddress) {
            selectedUsers.append(emailAddress)
            groupMemberLabel.text = selectedUsers.joined(separator: ", ")
        } else {
            guard let emailAddress = cell.emailAddress.text else { return }
            if selectedUsers.contains(emailAddress) {
                selectedUsers = selectedUsers.filter { $0 != emailAddress }
                groupMemberLabel.text = selectedUsers.joined(separator: ", ")
            }
        }
        
        if selectedUsers.count > 0 {
            checkDoneVisible()
        } else {
            groupMemberLabel.text = "people.add()"
            checkDoneVisible()
        }
    }
    
    @objc private func checkDoneVisible() {
        done.isHidden = !(selectedUsers.count > 0 && titleText.text != "" && descriptionText.text != "")
    }
}
