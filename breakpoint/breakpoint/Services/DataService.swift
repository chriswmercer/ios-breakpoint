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
            REF_FEED.childByAutoId().updateChildValues(["content" : "message", "senderid" : uid])
            completion(true)
        }
    }
}
