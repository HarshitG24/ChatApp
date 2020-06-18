//
//  GroupFeedCell.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/17/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var msg: UILabel!
    
    func customizeCell(name: String, img: UIImage, msg: String){
        self.profileimg.image = img
        self.username.text = name
        self.msg.text = msg
    }
}
