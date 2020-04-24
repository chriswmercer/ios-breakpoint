//
//  PostViewController.swift
//  breakpoint
//
//  Created by Chris Mercer on 23/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postText.delegate = self
        sendButton.bindToKeyboard()
        DataService.instance.getUsername(forUID: Auth.auth().currentUser!.uid) { (email) in
            self.usernameLabel.text = email
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postText.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if postText.text == "" {
            postText.text = TEXT_POST_PLACEHOLDER
        }
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
       
    @IBAction func sendButtonWasPressed(_ sender: Any) {
        guard let message = postText.text , message != TEXT_POST_PLACEHOLDER else { return }
        guard let userid = Auth.auth().currentUser?.uid else { return }
        DataService.instance.uploadPost(withMessage: message, forUID: userid, withGroupKey: nil) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
                self.postText.text = ""
            }
        }
    }
}
