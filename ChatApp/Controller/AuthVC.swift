//
//  AuthVC.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signInWithEmail(_ sender: Any){
        let loginvc = (storyboard?.instantiateViewController(identifier: "LoginVC"))!
        present(loginvc, animated: true, completion: nil)
    }
}
