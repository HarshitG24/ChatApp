//
//  AuthService.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    static var instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) -> ()){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                print(error?.localizedDescription)
                userCreationComplete(false, error)
                return
            }

            let userData = ["provider": user.providerID, "email": user.email]

            DataService.instance.addUserDB(uid: user.uid, userData: userData as Dictionary<String, Any>)
            userCreationComplete(true, nil)
        }
        
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            if error != nil{
                loginComplete(false, error)
                return
            }
            
            loginComplete(true, nil)
        }
    }
}
