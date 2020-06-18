//
//  Groups.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/17/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import Foundation

class Groups{
    private(set) public var groupTitle: String
    private(set) public var groupDescription: String
    private(set) public var groupMembersCount: String
    private(set) public var groupKey: String
    private(set) public var groupMembers: [String]
    
    init(title: String, desc: String, count: String, key: String, members: [String]) {
    
        self.groupTitle = title
        self.groupDescription = desc
        self.groupMembersCount = count
        self.groupKey = key
        self.groupMembers = members
    }
}
