//
//  CreatePostVC.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/15/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var thePost: UITextView!
    @IBOutlet weak var sendbtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        thePost.delegate = self
        sendbtn.bindToKeyboard()
    }
    
    @IBAction func uploadToFirebase(_ sender: Any) {
        
        if thePost.text != nil && thePost.text != "Write something here"{
            sendbtn.isEnabled = true
            
            DataService.instance.uploadPost(withMessage: thePost.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: nil) { (isComplete) in
                
                if isComplete{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("there was an error")
                }
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        thePost.text = ""
    }
}
