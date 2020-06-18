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
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            uploadComplete(true)
        }else{
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            uploadComplete(true)
        }
        
    }
    
    func getUsername(forUid uid: String, handler: @escaping (_ username: String) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (DataSnapshot) in
            
            guard let usrobj = DataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in usrobj{
                if user.key == uid{
                    print("email: " + (user.childSnapshot(forPath: "email").value as! String))
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ message: [Feed]) -> ()){
        
        var msgArray = [Feed]()
        
        REF_FEED.observeSingleEvent(of: .value) { (snapshot) in
            guard let snapobjects = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for msg in snapobjects{
                let content = msg.childSnapshot(forPath: "content").value as! String
                let senderId = msg.childSnapshot(forPath: "senderId").value as! String
                
                let message = Feed(content: content, senderId: senderId)
                msgArray.append(message)
            }
            
            handler(msgArray)
        }
    }
    
    func getAllGroupMessages(desiredGroup group: Groups, handler: @escaping (_ msgArr: [Feed]) -> ()){
        
        var grpmsg = [Feed]()
        
        REF_GROUPS.child(group.groupKey).child("messages").observeSingleEvent(of: .value) { (groupSnapShot) in
            
            guard let grpSnap = groupSnapShot.children.allObjects as? [DataSnapshot] else { return }
            
            for msg in grpSnap{
                let content = msg.childSnapshot(forPath: "content").value as! String
                let senderId = msg.childSnapshot(forPath: "senderId").value as! String
                
                let message = Feed(content: content, senderId: senderId)
                
                grpmsg.append(message)
            }
            
            handler(grpmsg)
        }
    }
    
    func getemail(forSearchQuery query: String, handler: @escaping (_ emailArr: [String]) -> ()){
        var emailArray = [String]()
        
        // observe will be to track changes anywhere in the user child, including the sub child
        REF_USERS.observe(.value) { (dataSnapShot) in
            
            guard let users = dataSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for usr in users{
                let email = usr.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) && email != Auth.auth().currentUser?.email{
                    emailArray.append(email)
                }
            }
            
            handler(emailArray)
        }
    }
    
    func getIds(forUsernames usernames : [String], handler: @escaping (_ users: [String]) ->()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            var idArr = [String]()
            guard let usersnapshot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in usersnapshot{
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if usernames.contains(email){
                    idArr.append(user.key)
                }
            }
            
            handler(idArr)
        }
    }
    
    func createGroup(withTitle title: String, withDescription description: String, withMembers members : [String], handler: @escaping (_ groupCreated: Bool) -> ()){
        
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": members])
        handler(true)
    }
    
    func getEmailsFor(group: Groups, handler: @escaping (_ emails: [String]) -> ()){
        var emailArr = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            
            guard let usersnap = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersnap{
                if group.groupMembers.contains(user.key){
                    let email = user.childSnapshot(forPath: "email").value as! String
                    
                    emailArr.append(email)
                }
            }
            
            handler(emailArr)
        }
    }
    
    func getGroups(handler: @escaping (_ groupArr: [Groups]) -> ()){
        var groupsarray = [Groups]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupDatashot) in
            
            guard let groupsnapshot = groupDatashot.children.allObjects as? [DataSnapshot] else {return}
            
            for groups in groupsnapshot{
                let memArr = groups.childSnapshot(forPath: "members").value as! [String]
                
                if memArr.contains(Auth.auth().currentUser!.uid){
                    
                    let title = groups.childSnapshot(forPath: "title").value as! String
                    let description = groups.childSnapshot(forPath: "description").value as! String
                    
                    let group = Groups(title: title, desc: description, count: "\(memArr.count)", key: groups.key, members: memArr)
                    
                    groupsarray.append(group)
                }
            }
            handler(groupsarray)
        }
    }
}
