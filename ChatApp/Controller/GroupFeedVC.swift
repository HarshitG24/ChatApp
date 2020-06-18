//
//  GroupFeedVC.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/17/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var sendbtnView: UIView!
    @IBOutlet weak var txtip: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var msgTxtField: UITextField!
    
    var group: Groups?
    var groupMessages = [Feed]()
    
    func initData(forGroup group: Groups){
        self.group = group
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.groupTitle.text = self.group?.groupTitle
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapShot) in
            DataService.instance.getAllGroupMessages(desiredGroup: self.group!) { (grpMessages) in
                self.groupMessages = grpMessages
                self.groupFeedTableView.reloadData()
                
                // adding the scroll animation for table view
                if self.groupMessages.count > 0{
                    // at: is none, so that we can scroll to given indexpath..
                    self.groupFeedTableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendbtnView.bindToKeyboard()
    }
    
    
    
    
    @IBAction func backbtn(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        if msgTxtField.text != ""{
            msgTxtField.isEnabled = false
            sendBtn.isEnabled = false
            
            DataService.instance.uploadPost(withMessage: self.msgTxtField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: self.group?.groupKey) { (uploadStatus) in
                
                if uploadStatus{
                    self.msgTxtField.isEnabled = true
                    self.sendBtn.isEnabled = true
                    self.msgTxtField.text = ""
                }else{
                    print("error..")
                }
            }
        }
        
        
    }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupfeedcell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        
        let msg = self.groupMessages[indexPath.row]
        let image = UIImage(named: "defaultProfileImage")
        
        DataService.instance.getUsername(forUid: msg.senderId) { (email) in
            cell.customizeCell(name: email, img: image!, msg: msg.content)
        }
        
        return cell
    }


}
