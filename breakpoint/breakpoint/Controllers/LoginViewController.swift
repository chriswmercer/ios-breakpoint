//
//  LoginViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 22/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
        
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        guard let username = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if username != "" && password != "" {
            AuthService.instance.loginUser(withEmail: username, andPassword: password) { (success, error) in
                if success {
                    self.hasLoggedIn()
                } else {
                    print(String(describing: error?.localizedDescription))
                    
                    AuthService.instance.registerUser(withEmail: username, andPassword: password) { (sucecss, error) in
                        if success {
                            AuthService.instance.loginUser(withEmail: username, andPassword: password) { (success, nil) in
                                self.hasLoggedIn()
                            }
                        } else {
                            debugPrint("Error: ", String(describing: error))
                        }
                    }
                }
            }
        }
    }
    
    func hasLoggedIn() {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(NOTIFY_USER_LOGGED_IN), object: nil)
        }
    }
}
