//
//  authViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 22/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(NOTIFY_USER_LOGGED_IN), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            userLoggedIn()
        }
    }

    @IBAction func facebookButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func googleButtonPressed(_ sender: Any) {
    }
    
    @objc func userLoggedIn() {
        dismiss(animated: true, completion: nil)
    }
}
