//
//  GroupsVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit
import Firebase

class groupCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupID: UILabel!
    
}

class GroupsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    var groupIDList = [String]()
    var groupNameList = [String]()
    var currUser : String? = nil
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: groupCell = tableView.dequeueReusableCell(withIdentifier: "groupLabel", for: indexPath) as! groupCell
        cell.groupName.text = groupNameList[indexPath.row]
        cell.groupID.text = groupIDList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "groupSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
//        db.collection(K.userCollection).document(currUser!).collection(K.userG).addSnapshotListener { (querySnapshot, error) in
//            self.groupIDList = []
//            if let e = error {
//                print("There was an issue retrieving data from Firestore. \(e)")
//            } else {
//                if let snapshotDocs = querySnapshot?.documents {
//                    for doc in snapshotDocs {
//                        self.groupIDList.append(doc.documentID)
//                        DispatchQueue.main.async {
//                            self.performSegue(withIdentifier: "groupSegue", sender: self)
//                        }
//                    }
//                }
//            }
//        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "groupCell", bundle: nil), forCellReuseIdentifier: "groupLabel")
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        currUser = Auth.auth().currentUser?.uid
        loadEvents()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createGroupButton(_ sender: Any) {
        performSegue(withIdentifier: "createGroup", sender: self)
    }
    
    func loadEvents() {
        db.collection(K.userCollection).document(currUser!).collection(K.userG).addSnapshotListener { (querySnapshot, error) in
            self.groupNameList = []
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs {
                        self.groupNameList.append(doc.data()["name"] as! String)
                        self.groupIDList.append(doc.documentID)
                        DispatchQueue.main.async {
                               self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.groupNameList.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "groupSegue") {
            let vc = segue.destination as! OpenGroupVC
            let cell : groupCell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! groupCell
//            tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! groupCell
            vc.groupID = cell.groupID.text
            print(groupIDList)
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
