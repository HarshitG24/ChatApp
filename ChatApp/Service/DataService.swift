//
//  DataService.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/14/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

// This will be a singleton class.
class DataService{
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    // Getters:-
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference{
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference{
        return _REF_FEED
    }
    
    func addUserDB(uid: String,userData: Dictionary<String, Any>){
        _REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, uploadComplete: @escaping (_ status: Bool) -> ()){
        
        if groupKey != nil{
            // send to group ref
        }else{
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            uploadComplete(true)
        }
        
    }
}
