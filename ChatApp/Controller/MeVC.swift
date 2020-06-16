//
//  MeVC.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userdetails: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.username.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func logout(_ sender: Any) {
        let logoutPopUp = UIAlertController(title: "Logout?", message: "Are you sure, you want to logout", preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
            
            do {
                try Auth.auth().signOut()
                let loginVc = self.storyboard?.instantiateViewController(identifier: "AuthVC") as? AuthVC
                loginVc?.modalPresentationStyle = .fullScreen
                self.present(loginVc!, animated: true, completion: nil)
            }catch{
                
            }
        }
        
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp, animated: true, completion: nil)
    }
}
