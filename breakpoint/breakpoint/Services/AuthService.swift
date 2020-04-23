//
//  AuthService.swift
//  breakpoint
//
//  Created by Chris Mercer on 23/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let user = result?.user else {
                completion(false, error)
                return
            }
            
            let userData = ["provider" : user.providerID,
                            "email" : user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData as Dictionary<String, Any>)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard (result?.user) != nil else {
                completion(false, error)
                return
            }
            
            completion(true, nil)
        }
    }
}
