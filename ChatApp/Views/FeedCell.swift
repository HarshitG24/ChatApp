//
//  FeedCell.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    
    func configureCell(profile: UIImage, email: String, content: String){
        print("cell email is: " + email)
        self.profileimg.image = profile
        self.username.text = email
        self.msg.text = content
    }

}
