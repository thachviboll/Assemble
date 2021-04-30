//
//  OpenGroupVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit

class eventCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
}

class OpenGroupVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func createEventButton(_ sender: Any) {
        performSegue(withIdentifier: "createEventPageSegue", sender: self)
    }
    
    @IBAction func addFriendButton(_ sender: Any) {
        performSegue(withIdentifier: "addFriend", sender: self)
    }
    
    @IBAction func openFriendsListButton(_ sender: Any) {
        performSegue(withIdentifier: "displayFriendsList", sender: self)
    }
    
    
    var eventNameList = [String]()
    var descriptionList = [String]()
    var locationList = [String]()
    var dateList = [String]()
    
    var friendsList = [String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "createEventPageSegue") {
            let vc = segue.destination as! CreateEventVC
            vc.eventNameList = eventNameList
            vc.descriptionList = descriptionList
            vc.locationList = locationList
            vc.dateList = dateList
        }
        
        if (segue.identifier == "addFriend") {
            let vc = segue.destination as! AddFriendVC
            vc.friendsList = friendsList
        }
        
        if (segue.identifier == "displayFriendsList") {
            let vc = segue.destination as! FriendsListVC
            vc.friendsList = friendsList
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "eventCell", bundle: nil), forCellReuseIdentifier: "eventID")
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: eventCell = tableView.dequeueReusableCell(withIdentifier: "eventID", for: indexPath) as! eventCell
        cell.eventNameLabel?.text = eventNameList[indexPath.row]
        cell.descriptionLabel?.text = descriptionList[indexPath.row]
        cell.locationLabel?.text = locationList[indexPath.row]
        cell.dateLabel?.text = dateList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
