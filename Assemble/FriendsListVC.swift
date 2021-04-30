//
//  FriendsListVC.swift
//  Assemble
//
//  Created by Viboll Thach on 4/29/21.
//

import UIKit

class FriendsListVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var friendsListTableView: UITableView!
    
    var friendsList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsListTableView.delegate = self
        friendsListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friendsList[indexPath.row]
       
        return cell
    }
    
    
}


