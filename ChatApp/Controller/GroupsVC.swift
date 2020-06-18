//
//  SecondViewController.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/14/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var groupTableview: UITableView!
    
    var myGroupArr = [Groups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //observesengleevent is called once and executed once...
        // so we use observe, to observe all changes..
        DataService.instance.REF_GROUPS.observe(.value) { (datasnapshot) in
            DataService.instance.getGroups { (myGroups) in
                self.myGroupArr = myGroups
                self.groupTableview.reloadData()
            }
        }
    }


}


extension GroupsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupcell", for: indexPath) as? GroupCell else {return UITableViewCell()}
        
        let group = myGroupArr[indexPath.row]
        
        cell.configureCell(title: group.groupTitle, description: group.groupDescription, count: group.groupMembersCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard let groupvc = storyboard?.instantiateViewController(identifier: "GroupFeedVC") as? GroupFeedVC else { return }
        groupvc.modalPresentationStyle = .overFullScreen
        groupvc.initData(forGroup: myGroupArr[indexPath.row])
        present(groupvc, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
