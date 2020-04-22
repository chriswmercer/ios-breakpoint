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
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
