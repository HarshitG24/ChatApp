//
//  LoginVC.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInWithEmail(_ sender: Any) {
        
        AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success, error) in
            
            if success {
               // self.dismiss(animated: true, completion: nil)
                let vc = self.storyboard?.instantiateViewController(identifier: "FirstVC")
                vc?.modalPresentationStyle = .overFullScreen
                self.present(vc!, animated: true, completion: nil)
            }else{
                print(String(describing: error?.localizedDescription))
            }
            
            AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!) { (bool, error) in
                
                if success {
                    AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!) { (success, error) in
                        
                        if success{
                          //  self.dismiss(animated: true, completion: nil)
                          
                            
                        }else{
                            print(String(describing: error?.localizedDescription))
                        }
                    }
                }
            }
        }
    }
}

extension LoginVC: UITextFieldDelegate{ }
