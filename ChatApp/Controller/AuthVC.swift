//
//  AuthVC.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func signInWithEmail(_ sender: Any){
        let loginvc = (storyboard?.instantiateViewController(identifier: "LoginVC"))!
        present(loginvc, animated: true, completion: nil)
    }
}
