//
//  OpenGroupVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit
import Firebase

class eventCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
}

class OpenGroupVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    
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
    
    var currUser : String? = nil
    var groupID : String? = nil
    var eventNameList = [String]()
    var descriptionList = [String]()
    var locationList = [String]()
    var dateList = [String]()
    var friendsList = [String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "createEventPageSegue") {
            let vcE = segue.destination as! CreateEventVC
            vcE.eventNameList = eventNameList
            vcE.descriptionList = descriptionList
            vcE.locationList = locationList
            vcE.dateList = dateList
            vcE.friendsList = friendsList
            vcE.groupID = groupID
        }
        
        if (segue.identifier == "addFriend") {
            let vcF = segue.destination as! AddFriendVC
            vcF.friendsList = friendsList
            vcF.eventNameList = eventNameList
            vcF.descriptionList = descriptionList
            vcF.locationList = locationList
            vcF.dateList = dateList
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
        currUser = Auth.auth().currentUser?.uid
        loadEvents()
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
    
    func loadEvents() {
        db.collection(K.groupCollection).document(groupID!).collection(K.Group.events).addSnapshotListener { (querySnapshot, error) in
            self.eventNameList = []
            self.descriptionList = []
            self.locationList = []
            self.dateList = []
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs {
                        let data = doc.data()
                        self.eventNameList.append(data[K.Event.name] as! String)
                        self.descriptionList.append(data[K.Event.des] as! String)
                        self.locationList.append(data[K.Event.loc] as! String)
                        self.dateList.append(data[K.Event.date] as! String)
                        DispatchQueue.main.async {
                               self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.eventNameList.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                    
                
            }
        }
//        var groupList = [String]()
//        db.collection(K.userCollection).addSnapshotListener { (querySnapshot, error) in
//
////            self.eventNameList = []
////            self.descriptionList = []
////            self.locationList = []
////            self.dateList = []
////
//
//            if let e = error {
//                print("There was an issue retrieving data from Firestore. \(e)")
//            } else {
//                if let snapshotDocuments = querySnapshot?.documents {
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        if doc.documentID == self.currUser {
//
//                        }
//
////                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
////                            let newMessage = Message(sender: messageSender, body: messageBody)
////                            self.messages.append(newMessage)
////
////                            DispatchQueue.main.async {
////                                   self.tableView.reloadData()
////                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
////                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
////                            }
////                        }
//                    }
//                }
//            }
        }
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
