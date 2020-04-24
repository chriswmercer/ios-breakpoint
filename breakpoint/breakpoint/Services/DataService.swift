//
//  DataService.swift
//  breakpoint
//
//  Created by Chris Mercer on 22/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import Foundation
import Firebase

let BaseDB = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = BaseDB
    private var _REF_USERS = BaseDB.child("users")
    private var _REF_GROUPS = BaseDB.child("groups")
    private var _REF_FEED = BaseDB.child("feed")
    
    private var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    private var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    private var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    private var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, completion: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderid" : uid])
            completion(true)
        }
    }
    
    func getAllFeedMessage(handler: @escaping (_ messages: [Message]) -> ()) {
        var messages = [Message]()
        
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for item in feedMessageSnapshot {
                guard let content = item.childSnapshot(forPath: "content").value as? String else { continue }
                guard let senderId = item.childSnapshot(forPath: "senderid").value as? String else { continue }
                let newMessage = Message(content: content, senderId: senderId)
                messages.append(newMessage)
            }
            handler(messages)
        }
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let users = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in users {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
}
