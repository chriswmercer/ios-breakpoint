//
//  MeViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 23/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit
import Firebase

class MeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.profileEmail.text = Auth.auth().currentUser?.email ?? "?"
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
            AuthService.instance.logoutUser()
            let authVC = self.storyboard?.instantiateViewController(withIdentifier: STORYBOARD_ID_AUTH) as? AuthViewController
            authVC!.modalPresentationStyle = .fullScreen
            self.present(authVC!, animated: true, completion: nil)
        }
        logoutPopup.addAction(logoutAction)
        logoutPopup.addAction(cancelAction)
        present(logoutPopup, animated: true, completion: nil)
    }
}
