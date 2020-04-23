//
//  MeViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 23/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutPressed(_ sender: Any) {

    }
}
