//
//  CreateGroupVC.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/16/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    @IBOutlet weak var groupDescription: InsetTextField!
    @IBOutlet weak var groupTitle: InsetTextField!
    @IBOutlet weak var personSearch: InsetTextField!
    @IBOutlet weak var allEmails: UILabel!
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var usersTableView: UITableView!
    
    var emailArray = [String]()
    var choosenArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personSearch.delegate = self
        personSearch.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        donebtn.isHidden = choosenArray.count > 1 ? false : true
    }
    
    @objc func textfieldChanged(){
        if personSearch.text == ""{
            emailArray = []
            usersTableView.reloadData()
        }else{
            DataService.instance.getemail(forSearchQuery: personSearch.text!) { (emails) in
                self.emailArray = emails
                self.usersTableView.reloadData()
            }
        }
    }
    
    @IBAction func createGroup(_ sender: Any) {
        
        if groupTitle.text != "" && groupDescription.text != ""{
            DataService.instance.getIds(forUsernames: choosenArray) { (ids) in
                var userid = ids
                userid.append(Auth.auth().currentUser!.uid)
                
                DataService.instance.createGroup(withTitle: self.groupTitle.text!, withDescription: self.groupDescription.text!, withMembers: userid) { (groupCreated) in
                    
                    if groupCreated{
                        print("group created..")
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("error")
                    }
                }
            }
        }
        
    }
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "usercell", for: indexPath) as? UserCell else {return UITableViewCell()}
        
        let profileimg = UIImage(named: "defaultProfileImage")
        
        if choosenArray.contains(emailArray[indexPath.row]){
            cell.configureCell(profile: profileimg!, email: self.emailArray[indexPath.row], isSelected: true)
        }else{
            cell.configureCell(profile: profileimg!, email: self.emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        
        if !choosenArray.contains(cell.userEmail.text!){
            choosenArray.append(cell.userEmail.text!)
            allEmails.text = choosenArray.joined(separator: ", ")
            donebtn.isHidden = false
        }else{
            choosenArray = choosenArray.filter({ ($0) != cell.userEmail.text })
            
            if choosenArray.count >= 1{
                allEmails.text = choosenArray.joined(separator: ", ")
            }else{
                allEmails.text = "add people to group"
                donebtn.isHidden = true
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


extension CreateGroupVC: UITextFieldDelegate{
}
