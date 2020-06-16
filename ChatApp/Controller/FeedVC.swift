//
//  FirstViewController.swift
//  ChatApp
//
//  Created by Harshit Gajjar on 6/14/20.
//  Copyright © 2020 ThinkX. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var feedRows: UITableView!
    var msgArr = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
             DataService.instance.getAllFeedMessages { (feed) in
                self.msgArr = feed.reversed()
                self.feedRows.reloadData()
            }
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as? FeedCell else {return UITableViewCell()}
       
        let msg = self.msgArr[indexPath.row]
        let image = UIImage(named: "defaultProfileImage")
        DataService.instance.getUsername(forUid: msg.senderId) { (email) in
            cell.configureCell(profile: image!, email: email, content: msg.content)
        }
        return cell
        
    }
    
    
}

