//
//  Feed.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import Foundation

class Feed{
    private(set) public var content: String
    private(set) public var senderId: String
    
    init(content: String, senderId: String) {
        self.content = content
        self.senderId = senderId
    }
}
