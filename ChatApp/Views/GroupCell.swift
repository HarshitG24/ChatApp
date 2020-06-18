//
//  GroupCell.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/17/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupMembersCount: UILabel!
    
    func configureCell(title: String, description: String, count: String){
        self.groupTitle.text = title
        self.groupDescription.text = description
        self.groupMembersCount.text = count + " members"
    }
}
