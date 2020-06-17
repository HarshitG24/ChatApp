//
//  UserCell.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/16/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    var showing = false
    
    func configureCell(profile: UIImage, email: String, isSelected: Bool){
        self.profileImg.image = profile
        self.userEmail.text = email
        
        if isSelected{
            self.checkImg.isHidden = false
        }else{
            self.checkImg.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{
            if showing == false{
                self.checkImg.isHidden = false
                showing = true
            }else{
                self.checkImg.isHidden = true
                showing = false
            }
        }else{
            self.checkImg.isHidden = true
        }
    }

}
