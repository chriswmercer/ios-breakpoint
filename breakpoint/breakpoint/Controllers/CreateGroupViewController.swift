//
//  CreateGroupViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 24/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var peopleText: UITextField!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var groupMemberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
    }
    
    @IBAction func closeWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneWasPressed(_ sender: Any) {
    }

    @IBAction func peopleAddTextChanged(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
